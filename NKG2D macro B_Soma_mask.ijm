'Transforming mask array into soma mask images. Before running the script, making a folder for soma mask'
dir = getDirectory("select Soma mask input dir");
list = getFileList(dir);

dir5 = getDirectory("select 'Soma ROI' output folder");


for(a=0; a<list.length; a++) 
{

	path = dir + list[a];
	
	run("Text Image... ", "open=[path]");
	
	wait(200);

imageTitle=getTitle();
run("8-bit");
saveAs("Tiff", dir5+imageTitle);
imageTitle2=getTitle();
selectWindow(imageTitle2);
close();
}
