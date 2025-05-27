dir = getDirectory("select 'Original images' dir");
list = getFileList(dir);

dir2 = getDirectory("select 'Soma mask image' folder"); 
list2 = getFileList(dir2);

dir3 = getDirectory("select 'NKG2D_drawing particles' folder"); 

for(a=0; a<list.length; a++) 

{
open(dir+list[a]);
wait(200);
imageTitle=getTitle();
	
open(dir2+list2[a]);
wait(200);
imageTitle2=getTitle();
	
selectImage(imageTitle);
run("Z Project...", "projection=[Max Intensity]");
run("Split Channels");
selectImage(imageTitle);
close;

selectWindow(imageTitle2);
run("Create Selection");
run("Enlarge...", "enlarge=10");
selectWindow("C1-MAX_"+imageTitle);
run("Restore Selection");
run("Clear", "slice");
setThreshold(50, 255, "raw");
run("Create Selection");
run("Enlarge...", "enlarge=0.5");
run("Make Inverse");

selectWindow("C2-MAX_"+imageTitle);
run("Restore Selection");

selectWindow("C3-MAX_"+imageTitle);
run("Restore Selection");
run("Clear", "slice");
run("Select None");

selectWindow("C2-MAX_"+imageTitle);
run("Clear", "slice");
run("Select None");

selectWindow("C1-MAX_"+imageTitle);
run("Clear", "slice");
run("Select None");

selectWindow("C2-MAX_"+imageTitle);
setThreshold(65, 255, "raw");
run("Create Selection");
run("Analyze Particles...", "size=0.1-25 circularity=0-1.00 show=[Bare Outlines] summarize stack");
selectWindow("Drawing of C2-MAX_"+imageTitle);
saveAs("Tiff", dir3+"Drawing of C2-MAX_"+imageTitle);
close();
	
	
selectWindow("C1-MAX_"+imageTitle);
run("Create Selection");
roiManager("Add");
roiManager("Select", 0);
roiManager("Rename", "BtubIII");
roiManager("Measure");
run("Enlarge...", "enlarge=0.5");
roiManager("Add");
roiManager("Select", 1);
roiManager("Rename", "BtubIII enlarged");
roiManager("Measure");

selectWindow("C2-MAX_"+imageTitle);
roiManager("Select", 1);
run("Analyze Particles...", "size=0.1-25 circularity=0.00-1.00 include summarize");

selectWindow("C1-MAX_"+imageTitle);
run("Select None");

selectWindow("C3-MAX_"+imageTitle);
setThreshold(30, 255, "raw");
run("Despeckle");
run("Create Selection");
run("Enlarge...", "enlarge=1.5");


selectWindow("C1-MAX_"+imageTitle);
run("Restore Selection");
run("Make Inverse");
run("Clear", "slice");
run("Select None");
run("Create Selection");
roiManager("Add");
roiManager("Select", 2);
roiManager("Rename", "tdTomato+BtubIII+");
roiManager("Measure");
run("Enlarge...", "enlarge=0.5");
roiManager("Add");
roiManager("Select", 3);
roiManager("Rename", "tdTomato+BtubIII+ enlarged");
roiManager("Measure");

selectWindow("C2-MAX_"+imageTitle);
roiManager("Select", 3);
run("Analyze Particles...", "size=0.1-25 circularity=0.00-1.00 include summarize");

roiManager("Deselect");
roiManager("Delete");
selectWindow("C1-MAX_"+imageTitle);
close("C1-MAX_"+imageTitle);
selectWindow("C2-MAX_"+imageTitle);
close("C2-MAX_"+imageTitle);
selectWindow("C3-MAX_"+imageTitle);
close("C3-MAX_"+imageTitle);
selectWindow(imageTitle2);
close(imageTitle2);

}
