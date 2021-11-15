
package com.example.demo.controller;

import com.example.demo.domain.model.File;
import com.example.demo.repository.FileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/files")
public class FileController {

    @Autowired
    private FileRepository fileRepository;

    @PostMapping
    public String upload(@RequestParam("file") MultipartFile uploadedFile) {
        try {
            File file = new File();
            file.contenttype = uploadedFile.getContentType();
            file.data = uploadedFile.getBytes();

            return fileRepository.save(file).fileid.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    @GetMapping("/{id}")
    public ResponseEntity<byte[]> getFile(@PathVariable UUID id) {
        File file = fileRepository.findById(id).orElse(null);

        if (file == null) return ResponseEntity.notFound().build();

        return ResponseEntity.ok()
                .contentType(MediaType.valueOf(file.contenttype))
                .contentLength(file.data.length)
                .body(file.data);
    }


    @GetMapping
    public String hack() {
        return "<form method='POST' enctype='multipart/form-data' style='display:flex;'>" +
                "<input id='file' type='file' name='file' style='display:none' onchange='preview.src=window.URL.createObjectURL(event.target.files[0])'>" +
                "<label for='file' style='border:1px dashed #999'><img id='preview' style='width:64px;max-height:64px;object-fit:contain;border:none'></label>" +
                "<input type='submit' style='background:#0096f7;color: white;border: 0;border-radius: 3px;padding: 8px;' value='Upload'>" +
                "</form><div style='display:flex;flex-wrap:wrap;gap:1em;'>" + fileRepository.getFileIds().stream().map(id -> "<img src='/files/"+id+"' style='width:12em;height:12em;object-fit:contain'>").collect(Collectors.joining()) + "</div>";
    }
}