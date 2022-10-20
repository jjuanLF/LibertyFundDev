/*
    @author James Cote
    @date 2022-09-05
    @description LFGoogleDriveFile is a class that represents a file in Google Drive and provides
    api methods for moving and listing files.
    see https://developers.google.com/drive/api/v3/reference/files
*/
public with sharing class LFGoogleDriveFile {
    @AuraEnabled
    public String id; // google drive id
    @AuraEnabled
    public String name; // file name
    @AuraEnabled
    public String description; // file description (little used)
    @AuraEnabled
    public String mimeType; // document mime type
    @AuraEnabled
    public String webViewLink; // link to file editor/viewer
    @AuraEnabled
    public String iconLink; // link to document mime type icon (png format)

    static final public String CONST_UPLOAD_FOLDER_NAME = 'SF Uploads';
    static final public String CONST_UPLOAD_FOLDER_KEY = 'sfuploads000';
    static final public String CONST_API_URL = 'https://www.googleapis.com/drive/v3/files';

    /*
        @description getUploadFolder finds the users upload folder in google drive
        @param  auth provides authentication for the google drive api files list call
        @return String id of the users upload folder
    */
    public static String getUploadFolder(LFGoogleAuth auth) {
        Object cachedFolderId = Cache.Session.get(
            LFGoogleDriveFile.CONST_UPLOAD_FOLDER_KEY
        );
        if (cachedFolderId != null) {
            return (String) cachedFolderId;
        }

        String qUrl = getQueryUrl(
            '\'root\' IN parents AND mimeType = \'application/vnd.google-apps.folder\' AND name = \'' +
            LFGoogleDriveFile.CONST_UPLOAD_FOLDER_NAME +
            '\'',
            'files(id)'
        );
        String body = auth.newCall().setUrl(qUrl).setMethod('GET').send();
        ListResponse lr = (ListResponse) JSON.deserialize(
            body,
            ListResponse.class
        );
        if (lr == null || lr.files == null || lr.files.size() == 0) {
            throw new LFGoogleAuth.RESTException(200, 'directory not found');
        }

        String folderID = lr.files[0].id;
        Cache.Session.put(LFGoogleDriveFile.CONST_UPLOAD_FOLDER_KEY, folderID);
        return folderID;
    }

    /*
        @description listFolderQueryUrl creates files list query url
        @param qry files list query parameter
        @param fields contains a comma-separated list of fields for the response (if blank uses default)
        @return String url for files list query
    */
    private static String getQueryUrl(String qry, String fields) {
        String folderQuery = EncodingUtil.urlEncode(qry, 'UTF-8');
        String fieldList = EncodingUtil.urlEncode(
            fields > ''
                ? fields
                : 'files(id,name,mimeType,description,parents,webViewLink,iconLink)',
            'UTF-8'
        );
        String url = LFGoogleDriveFile.CONST_API_URL;
        url += '?supportsAllDrives=true&supportsTeamDrives=true&includeItemsFromAllDrives=true';
        url += '&fields=' + fieldList + '&q=' + folderQuery;
        return url;
    }

    /*
        @description op process the requests of listfolder or move and is available to the aura and flows controller
        @param requests is a list of requests from the aura or flow controller
        @return List<Result> are responses to the respective requests
    */
    @InvocableMethod
    public static List<Result> op(List<Request> requests) {
        List<Result> results = new List<Result>();

        for (Request rq : requests) {
            Result rx;
            switch on rq.opName {
                when 'listFolder' {
                    rx = listOp(rq);
                }
                when 'move' {
                    rx = moveOp(rq);
                }
                when else {
                    rx = new Result();
                    rx.success = false;
                    rx.msg = 'invalid operation ' + rq.opName;
                }
            }
            results.add(rx);
        }
        return results;
    }

    /*
        @description listOp lists the files in a folder
        @param req 
        @return Result
    */
    private static Result listOp(Request req) {
        Result rx = new Result();
        try {
            LFGoogleAuth auth = new LFGoogleAuth(req.settingsId,'');
            String folderId = LFGoogleDriveFile.getUploadFolder(auth);
            String listUrl = LFGoogleDriveFile.getQueryUrl(
                '\'' +
                folderId +
                '\' in parents AND mimeType != \'application/vnd.google-apps.folder\'',
                ''
            );
            String jsonResponse = auth.newCall().setUrl(listUrl).setMethod('GET').send();
            ListResponse lr = (ListResponse) JSON.deserialize(
                jsonResponse,
                ListResponse.class
            );
            if (lr == null || lr.files == null || lr.files.size() == 0) {
                rx.msg = 'no files found';
                return rx;
            } else {
                rx.driveList = lr.files;
                rx.success = true;
            }
        } catch (LFGoogleAuth.RESTException re) {
            rx.msg = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception e) {
            rx.msg = e.getMessage();
        }
        return rx;
    }

    /*
        @description moveOp moves a file specified by req.fileId in the users upload folder to the folder specified by req.folderId
        @param req
        @return Result shows success or failure of the move operation only
    */ 
    private static Result moveOp(Request req) {
        Result rx = new Result();

        LFGoogleAuth a = new LFGoogleAuth(req.settingsId,'');

        String moveUrl =
            LFGoogleDriveFile.CONST_API_URL +
            '/' +
            req.fileId +
            '?supportsAllDrives=true&supportsTeamDrives=true&enforceSingleParent=true&' +
            'addParents=' +
            req.folderId;
        try {
            String jsonResponse = a.newCall().setUrl(moveUrl).setMethod('PATCH').
                setBody('{}','').send();
            rx.driveList = new List<LFGoogleDriveFile>();
            rx.success = true;
            rx.msg = '';
        } catch (LFGoogleAuth.RESTException re) {
            rx.msg = re.getStatusCode().format() + ' ' + re.getMessage();
        } catch (Exception e) {
            rx.msg = e.getMessage();
        }
        return rx;
    }

    /*
        @description ListResponse allows deserialization of the drive
    */
    public class ListResponse {
        public String nextPageToken;
        public List<LFGoogleDriveFile> files;
    }

    /*
        @description Request is the input to the op method
    */
    public class Request {
        public Request(String settingsId, String op) {
            this.opName = op;
            this.settingsId = settingsId;
        }

        public Request setIds(String fileId, String folderId) {
            this.fileId = fileId;
            this.folderId = folderId;
            return this;
        }

        // fileId is the id of the file to be moved
        @InvocableVariable
        public String fileId;
        // folderId is the id of the folder to move the file to
        @InvocableVariable
        public String folderId;
        // opName is the operation to perform (list  or move)
        @InvocableVariable
        public String opName;
        // settingsId is the id of the Google_API__mdt record
        @InvocableVariable
        public String settingsId;
    }

    /*
        @description Result is the output of the op method
    */
    public class Result {
        // drivelList is a list of files from the user's upload folder
        @InvocableVariable
        public List<LFGoogleDriveFile> driveList;
        // success is true if the operation was successful
        @InvocableVariable
        public Boolean success;
        // msg is a message describing the result of the operation
        @InvocableVariable
        public String msg;

        public Result() {
            this.success = false;
            this.msg = '';
            this.driveList = new List<LFGoogleDriveFile>();
        }
    }
}