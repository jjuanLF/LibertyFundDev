@isTest global class LFGoogleDriveApiMockHttpCallout implements HttpCalloutMock {
    private final String const_json_mime = 'application/json';
    public Boolean returnError = false;
    private String listResponseTest = '';

    public LFGoogleDriveApiMockHttpCallout(String listResponse) {
        this.listResponseTest = listResponse;
    }

    public class MockResponse {
        public String status;
        public String error;
        public Object obj;
        public Integer status_code;

        public MockResponse() {
            status = 'OK';
            error = '';
            status_code = 200;
        }

        public MockResponse Err(Integer status_code, String error, Object obj) {
            this.status = 'Err';
            this.status_code = status_code;
            this.error = error;
            this.obj = obj;
            return this;
        }
    }

    global HTTPResponse respond(HTTPRequest req) {
        Url url = new Url(req.getEndpoint());
        String qry = url.getQuery();
        String u = url.getProtocol() + '://' + url.getHost() + url.getPath();
        Map<String,String> params = getParams(qry);
        MockResponse mr;

        System.debug(u);
        switch on u {
            when 'https://www.googleapis.com/drive/v3/files/FILEID' {
                mr = this.HandleMove(req, params);
            }
            when 'https://www.googleapis.com/drive/v3/files' {
                System.debug('Starting HandleList');
                mr = this.HandleList(req, params);
            }
            when 'https://lf.org/1' {
                System.debug('Starting Handl 1 ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZz');
                mr = this.Handle1(req);
            }
            when 'https://lf.org/2' {
                System.debug('Starting Handl 2 ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZz');
                mr = this.Handle2(req);
            }
            when 'https://lf.org/3' {
                System.debug('Starting Handl 3 ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZz');
                mr = this.Handle3(req);
            }
            when 'https://accounts.google.com/o/oauth2/auth' {
                System.debug('Starting Handle token ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZz');
                mr = this.HandleToken(req);
            }
            when 'https://fail.google.com/token' {
                System.debug('Starting fail token ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZz');
                mr = new MockResponse();
                mr.obj = '{"token": "no access"}';
            }
            when else {
                System.debug('Starting Handl 4 ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZz');
                mr = new MockResponse();
                mr.status_code = 400;
                mr.obj = 'URL: ' + u;
            }
        }
        if (returnError) {
            mr.status_code = 400;
        } else if (mr.status_code == 0) {
            mr.status_code = 200;
        }
        
        HTTPResponse res = new HttpResponse();
        res.setStatusCode(mr.status_code);
        System.debug(mr.status_code);
        res.setHeader('Content-Type', const_json_mime);
        Object resObj = mr;
        if (mr.obj != null) { 
            System.debug(mr.obj);
            resObj = mr.obj;
        }
        if (resObj instanceof String) {
            System.debug('Has string ' + (String) resObj);
            res.setBody((String) resObj);
            return res;
        }
        String result = JSON.serialize(resObj); 
        System.debug('result: ' + result);
        res.setBody(result);
        return res;
    }

    private Map<String,String> getParams(String qry) {
        Map<String,String> pmap = new Map<String,String>();
        if (qry == null) {
            return pmap;
        }
        if (qry.startsWith('?')) {
            qry = qry.substring(1);
        }
        List<String> params = qry.split('&');
        for (String p: params) {
            List<String> keyvalue = p.split('=');
            if (keyvalue.size() == 0) {
                keyvalue.add('');
            }
            pmap.put(keyvalue[0], keyvalue[1]);
        }
        return pmap;
    }

    private MockResponse checkHeaders(HttpRequest req, String expected_method, 
        String expected_body, Map<String,String> pmap ) {
        MockResponse mr = new MockResponse();
        String method = req.getMethod();
        String ct = req.getHeader('Content-Type') == null? '': req.getHeader('Content-Type');
        String hdr_auth = req.getHeader('Authorization') == null ? '' : req.getHeader('Authorization');
        String body = req.getBody() == null ? '' : req.getBody();
        String expectedCT = method == 'GET' ? '' : const_json_mime;    
        if (method != expected_method || ct != expectedCT  
            || hdr_auth == null || !hdr_auth.startsWith('Bearer TOKEN') 
            || req.getBody() != expected_body) {
            return mr.Err(403, '',
                String.format('expected method {0} with Content-Type {1}, got {2} {3}; expected auth Bearer XXX, got {4}', 
                new List<String>{expectedCT, method, ct, hdr_auth}));
        }
        System.debug('checking pmap');
        if (pmap.size() == 0) 
            return mr.Err(400,'','no query arguments specified');             
        return mr;
    }
    
    private MockResponse HandleMove(HttpRequest req, Map<String,String> pmap) {
        MockResponse mr = this.checkHeaders(req, 'PATCH', '{}', pmap);
        if (mr.status == 'Err')
            return mr;
        String p = pmap.get('addParents') == null ? '' : pmap.get('addParents');
        String singleParent = pmap.get('enforceSingleParent') == null ? '' : pmap.get('enforceSingleParent');
        
        System.debug('checking fields addParents and singleParent');
        if (p != 'NEWFOLDERID' || singleParent != 'true') 
            return mr.Err(400, '', 
                'expected addParents=NEWFOLDERID&enforceSingleParent; got addParents = ' + p + ' enforceSingleParent = ' +singleParent);
        mr.obj = '{}';
        return mr;
    }

    private MockResponse HandleList(HttpRequest req, Map<String,String> pmap) {
        MockResponse mr = this.checkHeaders(req, 'GET', '', pmap);
        if (mr.status == 'Err')
            return mr;
        String flds = pmap.get('fields') == null ? '' : EncodingUtil.urlDecode(pmap.get('fields'),'UTF-8');
        String q = pmap.get('q') == null ? '' : EncodingUtil.urlDecode(pmap.get('q'),'UTF-8');
        System.debug('checking fields ' + flds);
        Boolean isFolderNameQuery = q.startsWith('\'root\''); 
        String expectedFlds = isFolderNameQuery ? 'files(id)' :
            'files(id,name,mimeType,description,parents,webViewLink,iconLink)';
        
        if (flds != expectedFlds) 
            return mr.Err(400, '', 'expected ' + expectedFlds + '; got ' + flds);
        
        if (isFolderNameQuery) {
            if (q.endsWith('name = \'FOLDERNOTFOUND\'')) {
                mr.obj = '{ "files": [] }';
                return mr;
            } 
            if (q.endsWith('name = \'JSONERROR\'')) {
                mr.obj = '}}';
                return mr;
            }
            mr.obj = '{ "files": [ {"id": "USER_FOLDERID"} ] }';
            return mr;
        }

        String expectedQ = 'FOLDERID\' in parents AND mimeType != \'application/vnd.google-apps.folder\''; 
        if (!q.endsWith(expectedQ))
            return mr.Err(400, '', 'expected ' + expectedQ + '; got ' + q);
    
        if (q.startsWith('\'BFOLDERID')) {
            mr.obj = '{}';
            return mr;
        }
        if (q.startsWith('\'CFOLDERID')) {
            mr.obj = '{{';
            return mr;
        }
        if (q.startsWith('\'XFOLDERID')) {
            mr.obj = '{ "files": [] }';
            return mr;
        }

        mr.obj = this.listResponseTest;
        return mr;    
    }

    private MockResponse HandleToken(HttpRequest req) {
        MockResponse mr = new MockResponse();
        System.debug(req.getBody());
        mr.obj =  new Map<String,String>{'access_token' => 'TOKENHTTP'};
        return mr;
    }

    private MockResponse Handle1(HttpRequest req) {
        System.debug('Starting handle1');
        MockResponse mr = new MockResponse();
        String method = req.getMethod();
        String accept = req.getHeader('Accept');
        String ct = req.getHeader('Content-Type');

        if (method != 'GET' || accept != const_json_mime || ct != null)
            return mr.Err(400, 
                String.format('expected method  = GET, got {0}; expected Accept = application/json, got {1}; expected empty Content-Type, got {2}', 
                new List<String>{method, accept, ct}), null);
        System.debug('mr.error ' + mr.error + 'XX');
        return mr;
    }

    private MockResponse Handle2(HttpRequest req) {
        MockResponse mr = new MockResponse();
        String hdr_accept = req.getHeader('Accept');
        String hdr_ct = req.getHeader('Content-Type');
        String method = req.getMethod();
        String body2 = req.getBody();
        if (method != 'POST' || hdr_accept != const_json_mime
            || hdr_ct != 'text/plain' || body2 != 'ABC')
                return mr.Err(200, 
                    String.format('expected method = POST, got {0}; expected Accept = application/json, got {1}; expected empty Content-Type, got {2}; expected body ABC, got {3}', 
                        new List<String>{method, hdr_accept, hdr_ct, body2}),null);
        return mr;
    }

    private MockResponse Handle3(HttpRequest req) {
        MockResponse mr = new MockResponse();
        String hdr_accept = req.getHeader('Accept');
        String hdr_ct = req.getHeader('Content-Type');
        String hdr_auth = req.getHeader('Authorization');
        if (hdr_auth == null)
            return mr.Err(400,'no auth header sent',null);

        if (!hdr_auth.startsWith('Bearer '))
            return mr.Err(400,'expected token starting Bearer; got ' + hdr_auth,null);

        String method = req.getMethod();
        String body2 = req.getBody();
        if (method != 'POST' || hdr_accept != const_json_mime
            || hdr_ct != 'text/plain' || body2 != 'VALUE')
                return mr.Err(400, String.format('expected method = POST, got {0}; expected Accept = application/json, got {1}; expected empty Content-Type, got {2}; expected body VALUE, got {3}', 
                    new List<String>{method, hdr_accept, hdr_ct, body2}), null);
        return mr;
    }
}