package com.devpro.service.impl;

import com.devpro.service.IUploadService;
import jakarta.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class UploadService implements IUploadService {

    @Autowired
    private ServletContext servletContext;

    @Override
    public String handleSaveUploadFile(String nameFile, MultipartFile file) {
        if (file.isEmpty()) {
            return "";
        }
        String rootPath = this.servletContext.getRealPath("/resources/admin/images");
        String finalName="";
        try {
            byte[] bytes = file.getBytes();


            File dir = new File(rootPath + File.separator+ nameFile);
            if (!dir.exists())
                dir.mkdirs();
            finalName=System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + finalName);


            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return finalName;
    }
}
