/*
    @author James Cote
    @date 2022-09-06
    @description LFGoogleAuth obtains a Google OAuth2 token for the session user.  Setting are stored using key name
    in Google_API__mdt and the key name references a system key that is used to create jwt signing requests. It caches the token
    in sesioncache and will refresh the token if it is expired.
*/
public with sharing class LFGoogleAuth {
    private String keyName = '';
    private String tokenUrl = 'https://accounts.google.com/o/oauth2/token';
    private String jwtIssuer = '';
    private String jwtAudience = 'https://accounts.google.com/o/oauth2/token';
    private String userEmail = '';
    private String scopes = '';
    private String cachedTokenKey = '';

    static final public String CONST_JSON_MIME = 'application/json';
    static final public String CONST_OAUTH2_HEADER = 'Authorization';
    static final public String CONST_JWT_GRANT_TYPE = 'urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer';

    /*
        @description LFGoogleAuth constructor instantiates settings for authorizing Google Drive api calls
        @param settingsId is key name that references an Google_API__mdt record that contains the jwt settings
    */
    public LFGoogleAuth(String settingsId, String email) {
        Google_API__mdt settings = Google_API__mdt.getInstance(settingsId); 
        this.keyName = settings.Key_ID__c;
        this.tokenUrl = settings.Token_URL__c;
        this.jwtIssuer = settings.Issuer__c;
        this.jwtAudience = settings.Token_URL__c;
        this.scopes = settings.Scopes__C;
        this.cachedTokenKey = settings.Cache_Key__c;

        this.userEmail = String.isNotBlank(email)
        ? email
        : UserInfo.getUserEmail();
    }

    /*
        @description getUserEmail returns that withh be used as jwt subject
    */
    public String getUserEmail() {
        return this.userEmail;
    }

    /* 
        @description getKeyName returns the key id in salesforce's certs and key list
    */
    public String getKeyName() {
        return this.keyName;
    }

    /*
        @description getIssuer returns google's service account email
    */
    public String getIssuer() {
        return this.jwtIssuer;
    }

    /*
        @description getTokenUrl returns google's jwt token endpoint
    */
    public String getTokenUrl() {
        return this.tokenUrl;
    }

    /*
        @description getTokenUrl returns google's jwt audience value
    */
    public String getJWTAud() {
        return this.jwtAudience;
    }

    /*
        @description getCacheTokenKey returns the session's cached access token
    */
    public String getCacheTokenKey() {
        return this.cachedTokenKey;
    }

    /*
        @description getAccessToken checks for an existing token in cache and
            creates and caches a new one if needed.
        @return String is the oauth2 access token
    */
    public String getAccessToken() {
        Object cachedToken = Cache.Session.get(this.cachedTokenKey);
        String accessToken = cachedToken != null ? (String) cachedToken : '';
        if (accessToken == '') {
            accessToken = this.newAccessToken();
            // cache new token
            Cache.Session.put(
                this.cachedTokenKey,
                accessToken,
                50 * 60
            );
        }
        return accessToken;
    }

    /*
        @description newAccessToken sends a signed jwt to google
        @return the access_token value
    */
    private String newAccessToken() {
        // create jwt for google
        Auth.JWT jwt = new Auth.JWT();
        jwt.setAud(this.jwtAudience);
        jwt.setIss(this.jwtIssuer);
        jwt.setSub(this.userEmail);
        Map<String, Object> scopeClaim = new Map<String, Object>{
            'scope' => this.scopes
        };
        jwt.setAdditionalClaims(scopeClaim);

        Auth.JWS signer;
        try {
            signer = new Auth.JWS(jwt, this.keyName);
        } catch (Exception e) {
            throw new RESTException(503, 'no access token returned');
        }
        // create form body
        String body =
            'grant_type=' +
            CONST_JWT_GRANT_TYPE +
            '&assertion=' +
            signer.getCompactSerialization();
        // get token via POST
        String tkbody = this.newCall().setUrl(this.tokenUrl).
            setMethod('POST').setBody(body, 'application/x-www-form-urlencoded').
            setUseAuth(false).send();
        // deserialize into map
        Map<String,Object> tokenValues = (Map<String,Object>)JSON.deserializeUntyped(tkbody);
        Object tk = tokenValues?.get('access_token');
        if (tk == null || !(tk instanceof String) || (String) tk == '') {
            throw new RESTException(200, 'no access token returned');
        }
        return (String) tk;
    }

    /*
        @description newCall creates a web request call using this LFGoogleAuth to set authentication headers
        @return Call is a web request
    */
    public Call newCall() {
        return new Call(this);
    }

    /*
        @description Call describes a web request.  Set statements are chainable.
    */
    public class Call {
        String url;
        String method;
        String body;
        String ct;
        Boolean useAuth;
        LFGoogleAuth lfga;

        public Call(LFGoogleAuth lfga) {
            this.url = '';
            this.method = '';
            this.ct = '';
            this.body = '';
            this.useAuth = true;
            this.lfga = lfga;
        }

        public call setUrl(String url) {
            this.url = url;
            return this;
        }
    
        public call setMethod(String method) {
            this.method = method;
            return this;
        }

        public call setBody(String body, String contentType) {
            this.body = body;
            this.ct = contentType;
            return this;
        }

        public call setUseAuth(Boolean auth) {
            this.useAuth = auth;
            return this;
        }

        /*
            @description send sends the web request
            @return String is a string of the response body
        */
        public String send() {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod(method);
            if (method != 'GET') {
                req.setBody(body);
                if (ct == '') {
                    ct = CONST_JSON_MIME;
                }
                req.setHeader('Content-Type', ct);
            }
            req.setHeader('Accept', CONST_JSON_MIME);
            if (useAuth) {
                req.setHeader(CONST_OAUTH2_HEADER, 'Bearer ' + lfga.getAccessToken());
            }
            HttpResponse res = new Http().send(req);
            String response = res.getBody();
            Integer statusCode = res.getStatusCode();
            if (statusCode < 200 || statusCode > 299) {
                throw new RESTException(statusCode, response);
            }
            return response;
        }
    }

    /*
        @description RESTException holds status information from api web requests
    */
    public class RESTException extends System.Exception {
        private Integer statusCode;
        private String msg;
        public RESTException(Integer code, String msg) {
            this.msg = msg;
            this.statusCode = code;
        }

        public Integer getStatusCode() {
            return statusCode;
        }

        public override String getMessage() {
            return this.msg;
        }
    }
}