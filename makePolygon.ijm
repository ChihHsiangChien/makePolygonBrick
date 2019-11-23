nPolygon = 4;
getSelectionCoordinates(x, y);
function xyRotate(x, y, nPolygon) {
	v_X1 = x[1] - x[0];
	v_Y1 = (y[1] - y[0]) * (-1);

	xArray = newArray();
	yArray = newArray();
	for (i = 0; i < nPolygon ; i++) {
		
		Radian = (360/nPolygon) * (PI/180) * (i+1) ;
		v_Xn = v_X1 * cos(Radian) - v_Y1 * sin(Radian);
		v_Yn = v_X1 * sin(Radian) + v_Y1 * cos(Radian);

		Xn = round(x[0] + v_Xn); 
		Yn = round(y[0] + v_Yn*(-1)); 
		
		xArray = Array.concat(xArray, Xn );
		yArray = Array.concat(yArray, Yn );		
		
	}
	xyArray = Array.concat(xArray, yArray);
	return xyArray;	
}

xy = xyRotate(x, y, nPolygon);
x = Array.slice(xy, 0, lengthOf(xy)/2);
y = Array.slice(xy, lengthOf(xy)/2);

//if selection will outside the canvas
distX = 0; 
distY = 0;
for (i = 0; i < lengthOf(x); i++) {
	//x
	if (x[i]< 0) {
		newdistX = abs(x[i] - 0 );
		if(newdistX > distX){distX = newdistX;}
	}
	if (x[i]> getWidth()) {
		newdistX = abs(x[i] - 0 );
		if(newdistX > distX){distX = newdistX;}
	}
	
	//y
	if (y[i]< 0) {
		newdistY = abs(y[i] - 0 );
		if(newdistY > distY){distY = newdistY;}
	}
	if (y[i]> getHeight()) {
		newdistY = abs(y[i] - 0 );
		if(newdistY > distY){distY = newdistY;}
	}
}

run("Canvas Size...", "width=" + getWidth()+ distX*2 +  " height=" + getHeight() + distY*2 +" position=Center zero");	

//

//
//translate new canvas - origin canvas
for (i = 0; i < lengthOf(x); i++) {
	x[i] = x[i] + distX;		
	y[i] = y[i] + distY;
}

//rotate array to make last point move to first point
Array.rotate(x, 1);
Array.rotate(y, 1);
makeSelection('polygon', x, y);

