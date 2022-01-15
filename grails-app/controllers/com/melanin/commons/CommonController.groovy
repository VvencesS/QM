package com.melanin.commons

import grails.plugin.springsecurity.SpringSecurityService
import melanin.log.MelaninLogService
import org.grails.encoder.CodecLookup
import org.springframework.web.multipart.MultipartFile

import java.nio.channels.FileChannel
import java.text.DateFormat
import java.text.SimpleDateFormat

class CommonController extends MelaninLogService {
    private static int STT_PROFILE_LUUTAM = 100000
    private static int STT_PROFILE_LUU = 100101
    SpringSecurityService springSecurityService
    def dataSource
    CodecLookup codecLookup

    def index() {}
    /**
     * Xử lý file upload
     * @param type
     * @param maxfilesize
     * check null
     * check định dạng
     * check dung lượng
     * check tạo thư mục lưu thành công
     */
    def static uploadfile(def fileupload, def type, def maxfilesize, String file_upload_type) {
        try {
            //TYPE YOUR OWN CODE HERE
            def sampleMap = [:]
            //1. check null file
            if (fileupload) {
                //CommonsMultipartFile file = fileupload
                MultipartFile file = fileupload
                if (!file.empty) {

                    //
                    Date date = Calendar.getInstance().getTime();
                    DateFormat monthFormat = new SimpleDateFormat("yyyyMM");
                    def currentMonth = monthFormat.format(date);
                    DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
                    def currentDate = dateFormat.format(date);
                    //
                    def currentTime = System.currentTimeMillis()
                    def fileName = file.getOriginalFilename().replaceAll(' ', '_')
                    //2. check file type
                    String extension = ""
                    int i = fileName.lastIndexOf('.')
                    if (i > 0) {
                        extension = fileName.substring(i + 1).toLowerCase()
                    }
                    String[] filetype = file_upload_type.split(",")
                    int checkfile = 0
                    for (int j = 0; j < filetype.size(); j++) {
                        if (extension == filetype[j] || extension.equals(filetype[j])) {
                            checkfile++
                        }
                    }
                    if (checkfile > 0) {
                        //3. check file size
                        if (file.getSize() <= maxfilesize) {
                            def path_dynamic = "\\" + type + "\\" + currentMonth + "\\" + currentDate + "\\" + currentTime
                            def path = Conf.findByLabel("UploadDir").value + path_dynamic
                            File f = new File(path)
                            if (f.mkdirs()) {
                                path_dynamic = path_dynamic + "\\" + fileName
                                path = path + "\\" + fileName
                                file.transferTo(new File(path))
                                sampleMap = ['filename': fileName, 'extension': extension, 'path': path_dynamic, 'fullpath': path, 'filesize': file.getSize()]
                            }
                        }
                    }
                }
            }
            return sampleMap
        } catch (Exception e) {
            throw e
        }
    }

    def static uploadMultiFile(def fileupload, def type, def maxfilesize, String file_upload_type) {
        try {
            //TYPE YOUR OWN CODE HERE
            def sampleMap = [:]
            def listSampleMap = []
            //1. check null file
            if (fileupload) {
                //CommonsMultipartFile file = fileupload
                fileupload.each { def fileTemp ->
                    MultipartFile file = fileTemp
                    if (!file.empty) {

                        //
                        Date date = Calendar.getInstance().getTime();
                        DateFormat monthFormat = new SimpleDateFormat("yyyyMM");
                        def currentMonth = monthFormat.format(date);
                        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
                        def currentDate = dateFormat.format(date);
                        //
                        def currentTime = System.currentTimeMillis()
                        def fileName = file.getOriginalFilename().replaceAll(' ', '_')
                        //2. check file type
                        String extension = ""
                        int i = fileName.lastIndexOf('.')
                        if (i > 0) {
                            extension = fileName.substring(i + 1).toLowerCase()
                        }
                        String[] filetype = file_upload_type.split(",")
                        int checkfile = 0
                        for (int j = 0; j < filetype.size(); j++) {
                            if (extension == filetype[j] || extension.equals(filetype[j])) {
                                checkfile++
                            }
                        }
                        if (checkfile > 0) {
                            //3. check file size
                            if (file.getSize() <= maxfilesize) {
                                def path_dynamic = "\\" + type + "\\" + currentMonth + "\\" + currentDate + "\\" + currentTime
                                def path = Conf.findByLabel("UploadDir").value + path_dynamic
                                File f = new File(path)
                                if (f.mkdirs()) {
                                    path_dynamic = path_dynamic + "\\" + fileName
                                    path = path + "\\" + fileName
                                    file.transferTo(new File(path))
                                    sampleMap = ['filename': fileName, 'extension': extension, 'path': path_dynamic, 'fullpath': path, 'filesize': file.getSize()]
                                }
                            }
                        }
                    }
                    listSampleMap << sampleMap

                }
            }
            return listSampleMap
        } catch (Exception e) {
            throw e
        }
    }

    def static uploadfileChangeFileName(def fileupload, def fileName,  def type, def maxfilesize, String file_upload_type) {
        try {
            //TYPE YOUR OWN CODE HERE
            def sampleMap = [:]
            //1. check null file
            if (fileupload) {
                //CommonsMultipartFile file = fileupload
                MultipartFile file = fileupload
                if (!file.empty) {

                    //
                    Date date = Calendar.getInstance().getTime();
                    DateFormat monthFormat = new SimpleDateFormat("yyyyMM");
                    def currentMonth = monthFormat.format(date);
                    DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
                    def currentDate = dateFormat.format(date);
                    //
                    def currentTime = System.currentTimeMillis()
//                    def fileName = file.getOriginalFilename().replaceAll(' ', '_')
                    //2. check file type
                    String extension = ""
                    int i = fileName.lastIndexOf('.')
                    if (i > 0) {
                        extension = fileName.substring(i + 1).toLowerCase()
                    }
                    String[] filetype = file_upload_type.split(",")
                    int checkfile = 0
                    for (int j = 0; j < filetype.size(); j++) {
                        if (extension == filetype[j] || extension.equals(filetype[j])) {
                            checkfile++
                        }
                    }
                    if (checkfile > 0) {
                        //3. check file size
                        if (file.getSize() <= maxfilesize) {
                            def path_dynamic = "\\" + type + "\\" + currentMonth + "\\" + currentDate + "\\" + currentTime
                            def path = Conf.findByLabel("UploadDir").value + path_dynamic
                            File f = new File(path)
                            if (f.mkdirs()) {
                                path_dynamic = path_dynamic + "\\" + fileName
                                path = path + "\\" + fileName
                                file.transferTo(new File(path))
                                sampleMap = ['filename': fileName, 'extension': extension, 'path': path_dynamic, 'fullpath': path, 'filesize': file.getSize()]
                            }
                        }
                    }
                }
            }
            return sampleMap
        } catch (Exception e) {
            throw e
        }
    }

    def private static isDate2AfterDate1(Date date1, Date date2) {
        if (date1.compareTo(date2) > 0) {
            return -1
        } else if (date1.compareTo(date2) < 0) {
            return 1
        } else if (date1.compareTo(date2) == 0) {
            return 0
        } else {
            return 999
        }
    }


    //copy file by channel
    private static void copyFileUsingFileChannels(File source, File dest)
            throws IOException {
        FileChannel inputChannel = null;
        FileChannel outputChannel = null;
        try {
            inputChannel = new FileInputStream(source).getChannel();
            outputChannel = new FileOutputStream(dest).getChannel();
            outputChannel.transferFrom(inputChannel, 0, inputChannel.size());
        } finally {
            if (inputChannel) inputChannel.close();
            if (outputChannel) outputChannel.close();
        }
    }

    //copy file by stream
    private static void copyFileUsingStream(String sourceUrl, String destUrl) throws IOException {
        File source = new File(sourceUrl);
        File dest = new File(destUrl);
        InputStream is = null;
        OutputStream os = null;
        try {
            is = new FileInputStream(source);
            os = new FileOutputStream(dest);
            byte[] buffer = new byte[1024];
            int length;
            while ((length = is.read(buffer)) > 0) {
                os.write(buffer, 0, length);
            }
        } finally {
            is.close();
            os.close();
        }
    }


    def replace_html_specialchar(String str) {
//        str = str.replaceAll("&", "&#38;")
//        str = str.replaceAll("<", "&lt;")
//        str = str.replaceAll(">", "&gt;")
//        str = str.replaceAll("\"", "&quot;")
//        str = str.replaceAll("\'", "''")
//        str = str.decodeHTML()
//        str = str.encodeAsHTML()
        str = codecLookup.lookupEncoder('HTML').encode(str)
        return str
    }

    //replace chuoi co ky tu ' thanh '' khi chay cau lenh select
    def replace_apostrophe(String str) {
        str = str.replaceAll("\'", "''")
        return str;
    }

    def static replace_url(String str) {
        str = str.replace("\\", "\\\\")
        return str;
    }

    def static replace_number(String str) {
        str = str.replace(",", "")
        return str;
    }


    def static getfilesize(String path) {
        File file = new File(path)
        if (file.exists()) {
            long bytes = file.length()
            return bytes
        } else {
            System.out.println("File does not exists!")
            return 0
        }
    }
}
