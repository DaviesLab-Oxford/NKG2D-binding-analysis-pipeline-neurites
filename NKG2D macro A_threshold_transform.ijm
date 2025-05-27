dir = getDirectory("select input dir");
list = getFileList(dir);

dir2 = getDirectory("select 'Neuron single channel' output folder");
dir3 = getDirectory("select 'Threshold and Transform' output folder");

for(a=0; a<list.length; a++) {

	open(dir+list[a]);
	wait(200);
	
	imageTitle=getTitle();

run("Z Project...", "projection=[Max Intensity]");
run("Split Channels");
selectWindow("C2-MAX_"+imageTitle);
saveAs("Tiff", dir2+"C2-MAX_"+imageTitle);
	imageTitle2=getTitle();
run("Set Scale...", "Image.removeScale");
run("Threshold...");
setThreshold(65, 255, "raw");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Divide...", "value=255");
run("16-bit");
selectWindow(imageTitle2);
saveAs("Tiff", dir3+"segm_"+imageTitle2);
	close();
selectWindow("C3-MAX_"+imageTitle);
	close();
selectWindow("C1-MAX_"+imageTitle);
	close();
selectWindow(imageTitle);
	close();
}
