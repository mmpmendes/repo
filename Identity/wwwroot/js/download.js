﻿function blazorDownloadFile(base64, contentType, fileName) {
    const link = document.createElement("a");
    link.href = `data:${contentType};base64,${base64}`;
    link.download = fileName;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}