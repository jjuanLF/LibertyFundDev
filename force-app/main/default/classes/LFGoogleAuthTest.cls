/*
@author James Cote
@date 2022-09-05
@description This programs contains test for LFGoogleDriveFile and LFGoogleAuth using MockHTTPCallouts.
*/

@isTest
public with sharing class LFGoogleAuthTest {
    public static final String TEST_SETTINGS_ID = 'JWT_Drive_API_TEST';

    /* 
        @description testConstructor validates LFGoogleAuth constructor
    */
    @isTest
    public static void testConstructor() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID, 'abc@lf.org');
        System.assertEquals('abc@lf.org', a00.getUserEmail(),
            'expected abc@lf.org; got ' + a00.getUserEmail());
        LFGoogleAuth a01 = new LFGoogleAuth(TEST_SETTINGS_ID, '');

        System.assertEquals('XXID', a01.getKeyName(),
            'expected XXID; got ' + a01.getKeyName());
        System.assertEquals('https://token.org/', a01.getTokenUrl(),
            'expected https://token.org/; got ' + a01.getTokenUrl());
        System.assertEquals('https://token.org/', a01.getJWTAud(),
            'expected https://token.org/' +  a01.getJWTAud());
        System.assertEquals('AAAAA ISSUER', a01.getIssuer(),
            'expected AAAAA ISSUER; got ' + a01.getIssuer());
    }

    /*
        @description opTest validates the listFolder and move operations
    */
    @isTest
    public static void opTest() {
        MockOp mo = new MockOp();

        Test.setMock(HttpCalloutMock.class, mo);
        List<LFGoogleDriveFile.Request> reqs = new List<LFGoogleDriveFile.Request> {
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'listFolder'),
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'listFolder'),
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'listFolder'),
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'listFolder'),
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'move').setIds('FILEID','FOLDERID'),
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'move').setIds('FILEID','FOLDERID'),
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'move').setIds('FILEID','FOLDERID'),
            new LFGoogleDriveFile.Request(TEST_SETTINGS_ID, 'noop').setIds('FILEID','FOLDERID')
        };
        List<LFGoogleDriveFile.Result> results = LFGoogleDriveFile.op(reqs);
        System.assert(
            !results[0].success && results[0].msg == '403 unauthorized',
            'wanted 403 unauthorized; got ' + results[0].msg
        );
        System.assert(
            !results[1].success &&
            results[1].msg.startsWith('Unexpected character'),
            results[1].msg
        );
        System.assert(
            !results[2].success && results[2].msg == 'no files found',
            results[2].msg
        );
        System.assert(
            results[3].success && results[3].driveList.size() == 3,
            'expected 3 files; got ' +
            results[3].driveList.size().format() +
            ' ' +
            results[3].msg
        );
        System.assert(
            !results[4].success && results[4].msg == '403 unauthorized',
            results[4].msg
        );
        System.assert(results[5].success, results[5].msg);
        System.assert(
            !results[6].success &&
            results[6].msg.startsWith('callout exception'),
            results[6].msg
        );
        System.assert(
            !results[7].success && results[7].msg == 'invalid operation noop',
            results[7].msg
        );
    }

    /*
        @description MockOp provides an HttpCalloutMock to test list and move operations
    */
    public class MockOp implements HttpCalloutMock {
        public Integer resultCode = 0;
        public String tokenUrl = '';
        public HTTPResponse respond(HTTPRequest req) {
            Url url = new Url(req.getEndpoint());
            String qry = url.getQuery();

            String u =
                url.getProtocol() +
                '://' +
                url.getHost() +
                url.getPath();
            Map<String, String> params = getParams(qry);
            String authHeader = req.getHeader('Authorization'); 
            if (String.isBlank(authHeader) ) {
                System.debug('Doing token......' + u);
                HttpResponse hr = getResponse(
                    200,
                    '{"access_token": "ACCESSTOKEN"}'
                );
                hr.setHeader('Content-Type', 'application/json');
                return hr;
            }

            if (
                params.containsKey('q') &&
                params.get('q').startsWith('%27root%27')
            ) {
                return getResponse(200, '{"files": [{"id": "FOLDERID"}]}');
            }

            Integer resCode = this.resultCode;
            this.resultCode++;
            switch on resCode {
                when 0, 4 {
                    return getResponse(403, 'unauthorized');
                }
                when 1 {
                    return getResponse(200, '{"files": ]}');
                }
                when 2 {
                    return getResponse(200, '{"files":[]}');
                }
                when 3 {
                    return getResponse(200, okListResponse());
                }
                when 5 {
                    return getResponse(200, '{}');
                }
                when 6 {
                    throw new CalloutException('callout exception');
                }
            }
            throw new UnexpectedException('invalid state');
        }
    }

    /*
            @description testGetToken00 validates LFGoogleAuth token retrieval authorization
    */
    @isTest
    public static void testGetToken00() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID, 'abc@lf.org');
        MockToken mt = new MockToken();
        Test.setMock(HttpCalloutMock.class, mt);
        mt.success = 2;
        String err = '';
        try {
            String fid = a00.getAccessToken();
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assertEquals('403 unauthorized', err,
            'expected 403 unauthorized; got ' + err);
    }

    /*
        @description testGetToken01 validates LFGoogleAuth json decoding checks
    */
    @isTest
    public static void testGetToken01() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID, 'abc@lf.org');
        MockToken mt = new MockToken();
        Test.setMock(HttpCalloutMock.class, mt);
        mt.success = 1;
        String err = '';
        try {
            String fid = a00.getAccessToken();
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assert(
            err.startsWith('Unexpected character'),
            'expected "Unexpected character"; got "' +
            err +
            '"'
        );
    }

    /*
        @description testGetToken02 validates LFGoogleAuth no access token returned checks
    */
    @isTest
    public static void testGetToken02() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID,'abc@lf.org');
        MockToken mt = new MockToken();
        Test.setMock(HttpCalloutMock.class, mt);
        mt.success = -1;
        String err = '';
        try {
            String tk = a00.getAccessToken();
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assertEquals('200 no access token returned', err,
            'expected 200 no access token returned; got ' + err);
    }

    /*
        @description testGetToken03 validates LFGoogleAuth access token caching
    */    
    @isTest
    public static void testGetToken03() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID,'abc@lf.org');
        MockToken mt = new MockToken();
        Test.setMock(HttpCalloutMock.class, mt);
        mt.success = 0;
        String err = '';
        try {
            String tk = a00.getAccessToken();
            System.assertEquals('ACCESSTOKEN', tk,
                'expected ACCESSTOKEN; got ' + tk);
            Object cachedToken = Cache.Session.get(
                a00.getCacheTokenKey()
            );
            System.assertEquals(tk, (String) cachedToken,
                'expected ' + cachedToken + '; got ' + tk);
            return;
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assert(false, err);
    }

    /*
        @description testGetFolder00 validates LFGoogleDriveFile authorization in listFolders method
    */
    @isTest
    public static void testGetFolder00() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID,'abc@lf.org');
        MockFolder mf = new MockFolder();
        Test.setMock(HttpCalloutMock.class, mf);
        mf.success = 3;
        mf.tokenUrl = a00.getTokenUrl();
        String err = '';
        try {
            String fid = LFGoogleDriveFile.getUploadFolder(a00);
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assertEquals('403 unauthorized', err,
            'expected 403 unauthorized; got ' + err);
    }

    /*
        @description testGetFolder01 validates json decoding check in LFGoogleDriveFile listFolder
    */
    @isTest
    public static void testGetFolder01() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID,'abc@lf.org');
        MockFolder mf = new MockFolder();
        Test.setMock(HttpCalloutMock.class, mf);
        mf.success = 2;
        mf.tokenUrl = a00.getTokenUrl();
        String err = '';
        try {
            String fid = LFGoogleDriveFile.getUploadFolder(a00);
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assert(
            err.startsWith('Unexpected close marker'),
            'expected "Unexpected close marker"; got "' +
            err +
            '"'
        );
    }

    /*
        @description testGetFolder02 validates empty return checks in LFGoogleDriveFile listFolder
    */
    @isTest
    public static void testGetFolder02() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID,'abc@lf.org');
        MockFolder mf = new MockFolder();
        Test.setMock(HttpCalloutMock.class, mf);
        mf.success = 1;
        mf.tokenUrl = a00.getTokenUrl();
        String err = '';
        try {
            String fid = LFGoogleDriveFile.getUploadFolder(a00);
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assertEquals('200 directory not found', err,
            'expected 200 directory not found; got '+ err);
    }

    /*
        @description testGetFolder03 validates LFGoogleDriveFile listFolder success
    */
    @isTest
    public static void testGetFolder03() {
        LFGoogleAuth a00 = new LFGoogleAuth(TEST_SETTINGS_ID,'abc@lf.org');
        MockFolder mf = new MockFolder();
        Test.setMock(HttpCalloutMock.class, mf);
        mf.success = 0;
        mf.tokenUrl = a00.getTokenUrl();
        String err = '';
        try {
            String fid = LFGoogleDriveFile.getUploadFolder(a00);
            System.assertEquals('FOLDERID', fid, 
                'expected FOLDERID; got ' + fid);
            return;
        } catch (LFGoogleAuth.RESTException re) {
            err = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception ex) {
            err = ex.getMessage();
        }
        System.assert(false, 'expected FOLDERID; got err="' + err + '"');
    }

    /*
        @description MockFolder provides an HttpCalloutMock for testing listFolder method
    */
    public class MockFolder implements HttpCalloutMock {
        public Integer success = 0;
        public String tokenUrl = '';
        public HTTPResponse respond(HTTPRequest req) {
            Url url = new Url(req.getEndpoint());
            String qry = url.getQuery();
            String u =
                url.getProtocol() +
                '://' +
                url.getHost() +
                url.getPath();
            Map<String, String> params = getParams(qry);
            String authHeader = req.getHeader('Authorization'); 
            if (String.isBlank(authHeader) ) {
            //if (u == this.tokenUrl) {
                HttpResponse hr = getResponse(
                    200,
                    '{"access_token": "ACCESSTOKEN"}'
                );
                hr.setHeader('Content-Type', 'application/json');
                return hr;
            }
            switch on success {
                when 0 {
                    return getResponse(200, '{"files": [{"id": "FOLDERID"}]}');
                }
                when 1 {
                    return getResponse(200, '{}');
                }
                when 2 {
                    return getResponse(200, '}');
                }
                when 3 {
                    return getResponse(403, 'unauthorized');
                }
            }
            throw new LFGoogleAuth.RESTException(400, 'invalid result value');
        }
    }

    /*
        @description MockToken provices HttpCalloutMock for testing token requests
    */
    public class MockToken implements HttpCalloutMock {
        public Integer success = 0;
        public String token = 'ACCESSTOKEN';

        public HTTPResponse respond(HTTPRequest req) {
            Url url = new Url(req.getEndpoint());
            String qry = url.getQuery();
            String u =
                url.getProtocol() +
                '://' +
                url.getHost() +
                url.getPath();
            String bd = req.getBody();
            System.debug(bd);
            Map<String, String> params = getParams(qry);
            switch on success {
                when -1 {
                    return getResponse(200, '{"token":""}');
                }
                when 0 {
                    return getResponse(200, '{"access_token": "ACCESSTOKEN"}');
                }
                when 1 {
                    return getResponse(200, '{body}');
                }
                when 2 {
                    return getResponse(403, 'unauthorized');
                }
            }
            throw new LFGoogleAuth.RESTException(400, 'invalid success value');
        }
    }

    /*
        @description getParams creates a map from a url query string
    */
    private static Map<String, String> getParams(String qry) {
        Map<String, String> pmap = new Map<String, String>();
        if (qry == null || qry == '') {
            return pmap;
        }
        if (qry.startsWith('?')) {
            qry = qry.substring(1);
        }
        List<String> params = qry.split('&');
        for (String p : params) {
            List<String> keyvalue = p.split('=');
            if (keyvalue.size() == 1) {
                keyvalue.add('');
            }
            pmap.put(keyvalue[0], keyvalue[1]);
        }
        return pmap;
    }

    /*
        @description getResponse creates an HttpResponse for a MockCallout to return
    */
    private static HttpResponse getResponse(Integer statusCode, String body) {
        HttpResponse hr = new HttpResponse();
        hr.setStatusCode(statusCode);
        hr.setBody(body);
        return hr;
    }

    /*
        @description okListResponse returns a successful list response
    */
    private static String okListResponse() {
        // List<String> listResponseTest =  new List<String>{
        return
            '{' +
            '  "files": [' +
            '{' +
            '"id": "1vNBuDm9EqHhEdLIvXucCZvmddKHyAOhqa6JSEDnnfT0",' +
            '"name": "Untitled spreadsheet",' +
            '"mimeType": "application/vnd.google-apps.spreadsheet",' +
            '"webViewLink": "https://docs.google.com/spreadsheets/d/1vNBuDm9EqHhEdLIvXucCZvmddKHyAOhLa6JSEDnnfT0/edit?usp=drivesdk",' +
            '"iconLink": "https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.google-apps.spreadsheet"' +
            '},' +
            '{' +
            '"id": "1DBnz-6dGEW_0mDqzSUP-qh9cp-C1H8qc",' +
            '"name": "invite test",' +
            '"mimeType": "application/vnd.google-apps.document",' +
            '"webViewLink": "https://drive.google.com/drive/folders/1DBnz-6dGEW_0mDFzSUP-qh9cp-C1H8qc",' +
            '"iconLink": "https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.google-apps.document"' +
            '},' +
            '{' +
            '"id": "1nHI3GnwISqjnq8HgqrRFzd86OMepYOsQ",' +
            '"name": "sf.testit.xls",' +
            '"mimeType": "application/vnd.ms-excel",' +
            '"webViewLink": "https://docs.google.com/spreadsheets/d/1nHI3GnwISqjn08HgqrRFzd86OMepYOsQ/edit?usp=drivesdk&ouid=111775723836348948767&rtpof=true&sd=true",' +
            '"iconLink": "https://drive-thirdparty.googleusercontent.com/16/type/application/vnd.ms-excel"' +
            '}' +
            ']' +
            '}' +
            '';
    }

/*  
    Used to test jwt body
    @isTest
    public static void testJWT(){
        Auth.JWT jwt = new Auth.JWT();
        String tokenUrl = 'https://accounts.google.com/o/oauth2/token'; 
        jwt.setAud(tokenUrl);
        jwt.setIss('lfsf-client-api@lf-domain-project.iam.gserviceaccount.com'); //libertyfundinc-hrd@appspot.gserviceaccount.com');
        jwt.setSub('jcote@libertyfund.org');
        Map<String, Object> scopeClaim = new Map<String, Object>{
            'scope' => 'https://www.googleapis.com/auth/drive'
        };
        jwt.setAdditionalClaims(scopeClaim);

        String keyname = 'd5274b7b5368ab85627048f54c144dd3d7e848d9';
        Auth.JWS signer;
        try {
            signer = new Auth.JWS(jwt, keyname);
        } catch (Exception e) {
            throw new LFGoogleAuth.RESTException(503, 'no access token returned');
        }
        // create form body
        String body =
            'grant_type=' +
            'urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer' +
            '&assertion=' +
            signer.getCompactSerialization();
            System.debug('FULL BODY');
            System.debug(body);
            System.debug('DONE'); 

            System.assertEquals( 'abc', body, 'msg');
    }
    */
}