// LFGoogleDriveApi provides methods for manipulating google drive
// files and folders.  The getAccessToken() method retrieves auth tokens
// from google using a signed JWT.  Tokens are cached using Session.Cache
public class LFGoogleDriveApi  {
    private String key_name = '';
    private String token_url = 'https://accounts.google.com/o/oauth2/auth';
    private String  jwt_iss = 'libertyfundinc-hrd@appspot.gserviceaccount.com';
    private String jwt_aud = 'https://accounts.google.com/o/oauth2/auth';
    private String user_email = '';
    static final private String sfUploadFolderName = 'Salesforce Uploads';
    static final private String qryFoldersOnly = 'mimeType = \'application/vnd.google-apps.folder\''; 
    static final private String qryFilesOnly = 'mimeType != \'application/vnd.google-apps.folder\''; 
    
    static final public String const_json_mime = 'application/json';
    static final public String const_jwt_grant_type = 'urn:ietf:params:oauth:grant-type:jwt-bearer';
    static final public String const_cache_key = 'lfgoogledrivetoken';
    static final public String const_user_upload_dir = 'lfgoogledrivefolder';
    static final public String const_key_id = 'd5274b7b5368ab85627048f54c144dd3d7e848d9';
    static final public String const_jwt_scope = 'https://www.googleapis.com/auth/drive';
    static final public String const_api_url = 'https://www.googleapis.com/drive/v3/files';
   
    // Constructor
    // @key_name: sf key for signing jwt
    // @google_email: user's google workspace email, empty indicates using SF email
    // @issuer: issuer id for jwt signature (testing only)
    // @tk_url: override standard google api url (testing only)
    public LFGoogleDriveApi(String key_name, String google_email, String issuer, String tk_url) {
        this.key_name = key_name > '' ? key_name : const_key_id;
        this.user_email = google_email > '' ? google_email : UserInfo.getUserEmail();
        if (tk_url != '') {
            this.token_url = tk_url;
            this.jwt_aud = tk_url;
        }
        if (issuer != '') {
            this.jwt_iss = issuer;
        }
    }

    // Constructor with default settings
    public LFGoogleDriveApi() {
        this('', '', '', '');
    }

    public String getUserEmail() {
        return this.user_email;
    }

    public String getKeyName() {
        return this.key_name;
    }

    public String getIssuer() {
        return this.jwt_iss;
    }

    public String getTokenUrl() {
        return this.token_url;
    }

    public String getJWTAud() {
        return this.jwt_aud;
    }

    // getAccessToken checks for an existing token in cache and
    // creates and caches a new one if needed.
    @TestVisible private String getAccessToken() {
        String access_token = getCachedAccessToken();
        if (access_token == '') {
            Auth.JWT jwt_token = this.buildJWT();
            access_token = this.newAccessToken(jwt_token);
            // cache new token
            Cache.Session.put(const_cache_key, access_token, 45 * 60);                
        }
        return access_token;
    }

    // get CachedAccessToken retreive the google access token from 
    // cache.  Empty results indicates no token in cache.
    @TestVisible private String getCachedAccessToken() {
        Object cached_token = Cache.Session.get(const_cache_key);
        if (cached_token != null) {
            return (String) cached_token;
        }
        return '';
    }

    // buildJWT creates an unsigned JWT object
    @TestVisible private Auth.JWT buildJWT() {
        Auth.JWT jwt = new Auth.JWT();
        jwt.setAud(this.jwt_aud);
        jwt.setIss(this.jwt_iss);
        jwt.setSub(this.user_email);
        Map<String,Object>scope_claim = new Map<String,Object>{'scopes' => const_jwt_scope}; 
        jwt.setAdditionalClaims(scope_claim);
        
        return jwt;
    }

    // newAccessToken sends a signed jwt to google and returns the access_token value
    @TestVisible private String newAccessToken(Auth.JWT token) {
        String body = 'grant_type=' + const_jwt_grant_type + '&assertion=' + 
                new Auth.JWS(token, const_key_id).getCompactSerialization();
        String token_response =this.sendHttpRequest(this.buildRequest(this.token_url, 'POST', body, 
            'application/x-www-form-urlencoded', false));
        Map<String, Object> tk = (Map<String, Object>) JSON.deserializeUntyped(token_response);
        if (!tk.containsKey('access_token')) {
            throw  new RESTException(200, 'no token returned ' + token_response);
        }
        return (String) tk.get('access_token');
    }

    // sentHttpRequest throws an exception if it does not retrieve a
    // 200 response. Returns response body.
    public String sendHttpRequest(HttpRequest req) {
        HttpResponse res = new Http().send(req);
        Integer status_code = res.getStatusCode();
        String body = res.getBody();
        if (status_code < 200 || status_code > 299) {
            throw new RESTException(status_code, body);
        }
        return body;
    }

    // buildRequest creates an HttpRequest for an api call
    // @url: url for request
    // @method: request method i.e. GET, POST, PATCH or DELETE
    // @body: json serialized string, leave blank for GET calls
    // @useAuth: indicate whether to include Authorization Bearer <oauth2 token> header    
    @TestVisible private HttpRequest buildRequest(String url, String method, String body, string ct, Boolean useAuth) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod(method);
        if (method != 'GET') {
            req.setBody(body);
            req.setHeader('Content-Type', ct);
        }
        req.setHeader('Accept', const_json_mime);
        if (useAuth) {
            String oauth2_token = this.getAccessToken(); 
            req.setHeader('Authorization','Bearer ' + oauth2_token);    
        }
        return req;
    }

    // listFolderQueryUrl creates a list api call
    private String getQueryUrl(String folder_id, String qry, String fields) {
        String folder_query = '\'' + folder_id + '\' in parents';
        if (qry > '')
            folder_query += ' AND ' + qry;
        String fieldList  = 'files(id,name,mimeType,description,parents,webViewLink,iconLink)';
        if (fields > '')
            fieldList = fields;
        
        folder_query = EncodingUtil.urlEncode(folder_query,'UTF-8');
        fieldList = EncodingUtil.urlEncode(fieldList, 'UTF-8'); 
        String url = const_api_url;
        url += '?supportsAllDrives=true&supportsTeamDrives=true&includeItemsFromAllDrives=true';
        url += '&fields=' + fieldList + '&q=' + folder_query;
        return url;
    }

    // fileListFromFolderUrl creates the url for querying files in folder
    @TestVisible private String fileListFromFolderUrl(String folder_id) {
        return getQueryUrl(folder_id, qryFilesOnly, '');
    }

    // fileListFromFolder returns all files from the users upload folder
    @TestVisible public List<File> fileListFromFolder() {
        String folderID = Cache.Session.get(const_user_upload_dir) == null ? '' :
            (String) Cache.Session.get(const_user_upload_dir);
        if (folderID == '') {
            folderID = this.getUploadFolderID();
            Cache.Session.put(const_user_upload_dir, folderID); // ttl 24 hours
        }
        return fileListFromFolder(folderID);
    }

    // fileListFromFolder returns all files within a drive folder
    // @folder_id: id of google folder
    @TestVisible public List<File> fileListFromFolder(String folder_id) {
        String url = this.fileListFromFolderUrl(folder_id);
        String body = this.sendHttpRequest(this.buildRequest(url, 'GET', ''));
        return listResponse(body);
    }

    @TestVisible private String getUploadFolderID() {
        return getFolderID('root',sfUploadFolderName);
    }

    // 
    @TestVisible public String getFolderID(String rootFolder,String folderName) {
        String url = getQueryUrl(rootFolder, qryFoldersOnly + ' AND name = \'' + folderName + '\'', 'files(id)');
        HttpRequest req = buildRequest(url, 'GET', '');
        String body= this.sendHttpRequest(req);
        List<file>file_list = listResponse(body);
        if (file_list.size() != 1) {
            throw new RESTException(200, 'UploadFolder not found');
        }
        return file_list[0].id;
    }

    // listResponse desrializes the passed string into a ListResponse object
    // and returns the file listing.
    private List<file> listResponse(String body) {
        if (body  != null && body != '') {
            try {
                ListResponse lr = (ListResponse) JSON.deserialize(body,ListResponse.Class);
                if (lr != null && lr.files != null) {
                    return lr.files;
                }    
            } catch (Exception e) {
                throw new LFGoogleDriveApi.RESTException(200, 'JSON DESERIALIZE: ' + e.getMessage());
            }
        }      
        return new List<file>();
    }

    // buildRequest assumes authorization and json content
    @TestVisible private HttpRequest buildRequest(String url, String method, String body) {
        return buildRequest(url, method, body, const_json_mime, true);
    }

    // ListResponse allows deserialization of the drive
    // api list call
    public class ListResponse {
        public String nextPageToken;
        public List<File> files;
    }

    // moveFileUrl creates the addParents command to move file
    @TestVisible private String moveFileUrl(String id, String new_folder_id) {
        String url = const_api_url;
        url += '/' + EncodingUtil.urlEncode(id,'UTF-8') + '?supportsAllDrives=true';
        url += '&supportsTeamDrives=true';
        url += '&enforceSingleParent=true';
        url += '&addParents=' + EncodingUtil.urlEncode(new_folder_id, 'UTF-8'); 
        return url;        
    }

    // moveFile moves a new folder.  The file will nolonger appear
    // in the original user folder.  Success is assumed by lack of exception
    // @id: drive file id
    // @new_folder_id: id of new parent folder
    public void moveFile(String id, String new_folder_id)  {
        String url = this.moveFileUrl(id, new_folder_id);
        String respString = this.sendHttpRequest(this.buildRequest(url, 'PATCH', '{}'));
        return;
    }

    // File is a pojo for
    // deserializing a file list
    public class File {
        public String id;               // google drive id
        public String name;             // file name 
        public String description;      // file description (little used)
        public List<String> parents;    // parent folder list
        public String mimeType;         // document mime type
        public String webViewLink;      // link to file editor/viewer 
        public String iconLink;         // link to document mime type icon (png format)
    }

    // RESTException holds status information 
    // from api http calle
    public class RESTException extends System.Exception {
        private Integer status_code;
        private String msg;
        public RESTException(Integer code, String msg) {
            this.msg = msg;
            this.status_code = code;
        }

        public Integer getStatusCode() {
            return status_code;
        }

        public override String getMessage() {
            return this.msg;
        }
    }
}