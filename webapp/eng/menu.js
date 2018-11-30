nMaxItem = 4;
NameIndex = 0;
DefaultState = 1;

MouseOverState = 2;
MouseDownState = 3;
imgCounter = 0;

ImageList = new Array();

bIsSupportOK = (
	((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) >= 3 )) ||
	((navigator.appName == "Microsoft Internet Explorer") && (parseInt(navigator.appVersion) >= 4 ))
);

function AddImageToImageList(name, Default, MouseOver, MouseDown)
{
	ImageList[imgCounter] = new Array(nMaxItem);
	ImageList[imgCounter][NameIndex] = name;
	ImageList[imgCounter][DefaultState] = new Image();
	ImageList[imgCounter][DefaultState].src = Default;
	if (MouseOver != "") {
		ImageList[imgCounter][MouseOverState] = new Image();
		ImageList[imgCounter][MouseOverState].src = MouseOver;
	}
	if (MouseDown != "") {
		ImageList[imgCounter][MouseDownState] = new Image();
		ImageList[imgCounter][MouseDownState].src = MouseDown;
	}

	imgCounter++;
}

function ReplaceImage(name, state)
{
	for (i = 0; i < imgCounter; i++) {
		if (document.images[ImageList[i][NameIndex]] != null) {
			if ((name == ImageList[i][NameIndex]) && (ImageList[i][state] != null))
				document.images[name].src = ImageList[i][state].src;
		}
	}
}


AddImageToImageList("U1", "images/leftnew1.jpg", "images/leftnew1b.jpg","images/leftnew1b.jpg");
AddImageToImageList("U2", "images/leftnew2.jpg", "images/leftnew2b.jpg","images/leftnew2b.jpg");
AddImageToImageList("U3", "images/leftnew3.jpg", "images/leftnew3b.jpg","images/leftnew3b.jpg");
AddImageToImageList("U4", "images/leftnew4.jpg", "images/leftnew4b.jpg","images/leftnew4b.jpg");
AddImageToImageList("U5", "images/leftnew5.jpg", "images/leftnew5b.jpg","images/leftnew5b.jpg");
AddImageToImageList("U6", "images/leftnew6.jpg", "images/leftnew6b.jpg","images/leftnew6b.jpg");
AddImageToImageList("U7", "images/leftnew7.jpg", "images/leftnew7b.jpg","images/leftnew7b.jpg");
AddImageToImageList("U8", "images/leftnew8.jpg", "images/leftnew8b.jpg","images/leftnew8b.jpg");
AddImageToImageList("U9", "images/leftnew9.jpg", "images/leftnew9b.jpg","images/leftnew9b.jpg");
AddImageToImageList("U10", "images/leftnew10.jpg", "images/leftnew10b.jpg","images/leftnew10b.jpg");
AddImageToImageList("U11", "images/leftnew11.jpg", "images/leftnew11b.jpg","images/leftnew11b.jpg");
AddImageToImageList("U12", "images/leftnew12.jpg", "images/leftnew12b.jpg","images/leftnew12b.jpg");
AddImageToImageList("U13", "images/leftnew13.jpg", "images/leftnew13b.jpg","images/leftnew13b.jpg");
AddImageToImageList("U14", "images/leftnew14.jpg", "images/leftnew14b.jpg","images/leftnew14b.jpg");
//AddImageToImageList("U15", "images/leftnew15.jpg", "images/leftnew15b.jpg","images/leftnew15b.jpg");
//AddImageToImageList("U16", "images/leftnew16.jpg", "images/leftnew16b.jpg","images/leftnew16b.jpg");
AddImageToImageList("U18", "images/leftnew18.jpg", "images/leftnew18b.jpg","images/leftnew18b.jpg");
