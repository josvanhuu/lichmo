// JScript File
function Rundate()
{
    var now=new Date()
    var hrs=now.getHours()
    var min=now.getMinutes()
    var sec=now.getSeconds()
    var day =now.getDate();
    var ngay=now.getDay();
    var month = now.getMonth()+1;
    var year = now.getFullYear();
    var strDate = "";
    var don="AM"
    if (hrs>=12){ don="PM" }
    if (hrs>12) { hrs-=12 }
    if (hrs==0) { hrs=12 }
    if (hrs<10) { hrs="0"+hrs }
    if (min<10) { min="0"+min }
    if (sec<10) { sec="0"+sec }
    switch(ngay)
    {
        case 0: strDate = "Chủ nhật, ";break;case 1:strDate = "Thứ 2, ";break;case 2:strDate = "Thứ 3, ";break;case 3:strDate = "Thứ 4, ";break;case 4:strDate = "Thứ 5, ";break;case 5:strDate = "Thứ 6, ";break;case 6:strDate = "Thứ 7, ";
    }
    document.getElementById('todaydate').innerHTML= strDate + day+"/"+month+"/"+year + " - " + hrs + ":" + min + ":" + sec + " " + don;
    setTimeout("Rundate()",1000);
}
function checkFile(filename,extallow)
{
    var fileext=filename.substr(filename.lastIndexOf('.'),4);
    if(filename=="")
        return true;
    else
    {
        if(extallow.indexOf(fileext.toLowerCase())<0)
            return false;
        else
            return true;
    }
}
function openPopup(url,top,left,width,height)
{
    window.open(url,'name','scrollbars=yes,menubar=yes,height='+height+',width='+width+',top='+top+',left='+left+'');
}
function switchDisplay(obj)
{
    if(obj.style.display=='none')
        obj.style.display='';
    else
        obj.style.display='none';
}
function isCheckbox(obj)
{
    if(obj.type=="checkbox")
        return true;
    else
        return false;
}
function CheckAll(name)
{
    var element=document.getElementsByTagName("input");
    for(i=0;i<element.length;i++)
    {
        if(isCheckbox(element[i]) && element[i].name.indexOf(name)>=0)
            element[i].checked=true;
    }
}
function UnCheckAll(name)
{
    var element=document.getElementsByTagName("input");
    for(i=0;i<element.length;i++)
    {
        if(isCheckbox(element[i]) && element[i].name.indexOf(name)>=0)
            element[i].checked=false;
    }
}
function checkDelete()
{
    var element=document.getElementsByTagName("input");
    for(i=0;i<element.length;i++)
    {
        if(isCheckbox(element[i]))
        {
            if(element[i].checked==true)
            {                
                if(confirm('Are you sure want to delete?'))
                {
                    return true;
                }
                else
                {
                    return false;
                }               
            }
        }
    }
    alert('You must select to delete!');                
    return false;    
}
function AddInputFile(Container,i)
{    
    if(i<=6)
        document.getElementById(Container).innerHTML+="Image: <input type='file' id='Image"+i+"' name='FileUpload"+i+"' />    BigImage: <input type='file' id='BigImage"+i+"' name='FileUpload"+i+"' /><br>";
    else
        alert('You can not add more!');
}
function Show(tabid)
{
    //tat tab cu
    $(".active").removeClass("active");
    $(".show").removeClass("show").addClass("hide");
    //bat tab moi
    $("#TabMenu"+tabid).addClass("active");
    $("#Tab"+tabid).addClass("show").removeClass("hide");
}

function isExpire(month,year)
{
    var date=new Date();
    if(parseInt(year,10)<date.getFullYear())
        return false;
    else if(parseInt(year,10)==date.getFullYear())
    {
        if(parseInt(month,10)<date.getMonth())
            return false;
        else
            return true;
    }
    else
        return true;
}
function addDate(dateString,num){
    var dateOnMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    var dateArray = new Array();
    var reStr = "";
    
    var date, month, year;
    
    dateArray = dateString.split("/");
    
    date = parseInt(dateArray[1]);
    month = parseInt(dateArray[0]);
    year = parseInt(dateArray[2]);
        
    if(year % 4 == 0){
        dateOnMonth[1]++;
    }
    
    date += num;
    while(date > dateOnMonth[month-1]){
        date -= dateOnMonth[month-1];
        if(month == 12){
            month = 1;
            year ++;
        }
        else{
            month++;
        }
    }
    
    reStr = month + "/" + date + "/" + year;
    return reStr;
}

/***********************************************
* Bookmark site script- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for full source code
***********************************************/

/* Modified to support Opera */
function bookmarksite(title,url){
if (window.sidebar) // firefox
	window.sidebar.addPanel(title, url, "");
else if(window.opera && window.print){ // opera
	var elem = document.createElement('a');
	elem.setAttribute('href',url);
	elem.setAttribute('title',title);
	elem.setAttribute('rel','sidebar');
	elem.click();
} 
else if(document.all)// ie
	window.external.AddFavorite(url, title);
}

function setHomePage(url)
{
if (document.all)
{
document.body.style.behavior='url(#default#homepage)';
document.body.setHomePage(url);

}
else if (window.sidebar)
{
if(window.netscape)
{
try
{
netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
}
catch(e)
{
alert("this action was aviod by your browser，if you want to enable，please enter about:config in your address line,and change the value of signed.applets.codebase_principal_support to true");
}
}
var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components. interfaces.nsIPrefBranch);
prefs.setCharPref('browser.startup.homepage',url);
}
} 
/*============================================================================*/

/*

This routine checks the credit card number. The following checks are made:

1. A number has been provided
2. The number is a right length for the card
3. The number has an appropriate prefix for the card
4. The number has a valid modulus 10 number check digit if required

If the validation fails an error is reported.

The structure of credit card formats was gleaned from a variety of sources on 
the web, although the best is probably on Wikepedia ("Credit card number"):

  http://en.wikipedia.org/wiki/Credit_card_number

Parameters:
            cardnumber           number on the card
            cardname             name of card as defined in the card list below

Author:     John Gardner
Date:       1st November 2003
Updated:    26th Feb. 2005      Additional cards added by request
Updated:    27th Nov. 2006      Additional cards added from Wikipedia
Updated:    18th Jan. 2008      Additional cards added from Wikipedia
Updated:    26th Nov. 2008      Maestro cards extended

*/

/*
   If a credit card number is invalid, an error reason is loaded into the 
   global ccErrorNo variable. This can be be used to index into the global error  
   string array to report the reason to the user if required:
   
   e.g. if (!checkCreditCard (number, name) alert (ccErrors(ccErrorNo);
*/

var ccErrorNo = 0;
var ccErrors = new Array ()

ccErrors [0] = "Unknown card type";
ccErrors [1] = "No card number provided";
ccErrors [2] = "Credit card number is in invalid format";
ccErrors [3] = "Credit card number is invalid";
ccErrors [4] = "Credit card number has an inappropriate number of digits";

function isValidCreditCard (cardname, cardnumber) {
     
  // Array to hold the permitted card characteristics
  var cards = new Array();

  // Define the cards we support. You may add addtional card types.
  
  //  Name:      As in the selection box of the form - must be same as user's
  //  Length:    List of possible valid lengths of the card number for the card
  //  prefixes:  List of possible prefixes for the card
  //  checkdigit Boolean to say whether there is a check digit
  
  cards [0] = {name: "Visa", 
               length: "13,16", 
               prefixes: "4",
               checkdigit: true};
  cards [1] = {name: "MasterCard", 
               length: "16", 
               prefixes: "51,52,53,54,55",
               checkdigit: true};
  cards [2] = {name: "DinersClub", 
               length: "14,16", 
               prefixes: "36,54,55",
               checkdigit: true};
  cards [3] = {name: "CarteBlanche", 
               length: "14", 
               prefixes: "300,301,302,303,304,305",
               checkdigit: true};
  cards [4] = {name: "AmEx", 
               length: "15", 
               prefixes: "34,37",
               checkdigit: true};
  cards [5] = {name: "Discover", 
               length: "16", 
               prefixes: "6011,622,64,65",
               checkdigit: true};
  cards [6] = {name: "JCB", 
               length: "16", 
               prefixes: "35",
               checkdigit: true};
  cards [7] = {name: "enRoute", 
               length: "15", 
               prefixes: "2014,2149",
               checkdigit: true};
  cards [8] = {name: "Solo", 
               length: "16,18,19", 
               prefixes: "6334, 6767",
               checkdigit: true};
  cards [9] = {name: "Switch", 
               length: "16,18,19", 
               prefixes: "4903,4905,4911,4936,564182,633110,6333,6759",
               checkdigit: true};
  cards [10] = {name: "Maestro", 
               length: "12,13,14,15,16,18,19", 
               prefixes: "5018,5020,5038,6304,6759,6761",
               checkdigit: true};
  cards [11] = {name: "VisaElectron", 
               length: "16", 
               prefixes: "417500,4917,4913,4508,4844",
               checkdigit: true};
               
  // Establish card type
  var cardType = -1;
  for (var i=0; i<cards.length; i++) {

    // See if it is this card (ignoring the case of the string)
    if (cardname.toLowerCase () == cards[i].name.toLowerCase()) {
      cardType = i;
      break;
    }
  }
  
  // If card type not found, report an error
  if (cardType == -1) {
     ccErrorNo = 0;
     return false; 
  }
   
  // Ensure that the user has provided a credit card number
  if (cardnumber.length == 0)  {
     ccErrorNo = 1;
     return false; 
  }
    
  // Now remove any spaces from the credit card number
  cardnumber = cardnumber.replace (/\s/g, "");
  
  // Check that the number is numeric
  var cardNo = cardnumber
  var cardexp = /^[0-9]{13,19}$/;
  if (!cardexp.exec(cardNo))  {
     ccErrorNo = 2;
     return false; 
  }
       
  // Now check the modulus 10 check digit - if required
  if (cards[cardType].checkdigit) {
    var checksum = 0;                                  // running checksum total
    var mychar = "";                                   // next char to process
    var j = 1;                                         // takes value of 1 or 2
  
    // Process each digit one by one starting at the right
    var calc;
    for (i = cardNo.length - 1; i >= 0; i--) {
    
      // Extract the next digit and multiply by 1 or 2 on alternative digits.
      calc = Number(cardNo.charAt(i)) * j;
    
      // If the result is in two digits add 1 to the checksum total
      if (calc > 9) {
        checksum = checksum + 1;
        calc = calc - 10;
      }
    
      // Add the units element to the checksum total
      checksum = checksum + calc;
    
      // Switch the value of j
      if (j ==1) {j = 2} else {j = 1};
    } 
  
    // All done - if checksum is divisible by 10, it is a valid modulus 10.
    // If not, report an error.
    if (checksum % 10 != 0)  {
     ccErrorNo = 3;
     return false; 
    }
  }  

  // The following are the card-specific checks we undertake.
  var LengthValid = false;
  var PrefixValid = false; 
  var undefined; 

  // We use these for holding the valid lengths and prefixes of a card type
  var prefix = new Array ();
  var lengths = new Array ();
    
  // Load an array with the valid prefixes for this card
  prefix = cards[cardType].prefixes.split(",");
      
  // Now see if any of them match what we have in the card number
  for (i=0; i<prefix.length; i++) {
    var exp = new RegExp ("^" + prefix[i]);
    if (exp.test (cardNo)) PrefixValid = true;
  }
      
  // If it isn't a valid prefix there's no point at looking at the length
  if (!PrefixValid) {
     ccErrorNo = 3;
     return false; 
  }
    
  // See if the length is valid for this card
  lengths = cards[cardType].length.split(",");
  for (j=0; j<lengths.length; j++) {
    if (cardNo.length == lengths[j]) LengthValid = true;
  }
  
  // See if all is OK by seeing if the length was valid. We only check the 
  // length if all else was hunky dory.
  if (!LengthValid) {
     ccErrorNo = 4;
     return false; 
  };   
  
  // The credit card is in the required format.
  return true;
}

/*============================================================================*/

function FloatTopDiv()
	{
		startX = document.body.clientWidth - 110, startY = 71;
		var ns = (navigator.appName.indexOf("Netscape") != -1);
		var d = document;
		if (document.body.clientWidth < 980) startX = -110;		
		function ml(id)
		{
			var el=d.getElementById?d.getElementById(id):d.all?d.all[id]:d.layers[id];
			if(d.layers)el.style=el;
			el.sP=function(x,y){this.style.left=x+'px';this.style.top=y+'px';};
			el.x = startX;
			el.y = startY;
			return el;
		}
		window.stayTopLeft=function()
		{
			if (document.body.clientWidth < 980)
			{
				ftlObj.x = -110;ftlObj.y = 0;	ftlObj.sP(ftlObj.x, ftlObj.y);
			}
			else
			{
			if (document.documentElement && document.documentElement.scrollTop)
				var pY = ns ? pageYOffset : document.documentElement.scrollTop;
			else if (document.body)
				var pY = ns ? pageYOffset : document.body.scrollTop;

			if (document.body.scrollTop > 71){startY = 3} else {startY = 71};

			if (document.body.clientWidth <= 1024)
			{
				ftlObj.x = document.body.clientWidth -110;ftlObj.y += (pY + startY - ftlObj.y)/32;ftlObj.sP(ftlObj.x, ftlObj.y);
			}
			else if(document.body.clientWidth > 1024)
			{
				ftlObj.x = document.body.clientWidth -110;ftlObj.y += (pY + startY - ftlObj.y)/32;ftlObj.sP(ftlObj.x, ftlObj.y);
			}
			else
			{
			ftlObj.x  = startX;
			ftlObj.y += (pY + startY - ftlObj.y)/32;
			ftlObj.sP(ftlObj.x, ftlObj.y);
			}
			}
			setTimeout("stayTopLeft()", 1);
		}
		ftlObj = ml("divAdRight");
		stayTopLeft();
	}
function FloatTopDiv2()
	{
		startX2 = document.body.clientWidth - 110, startY2 = 71;
		var ns2 = (navigator.appName.indexOf("Netscape") != -1);
		var d2 = document;
		if (document.body.clientWidth < 980) startX2 = -110;
		function ml2(id)
		{
			var el2=d2.getElementById?d2.getElementById(id):d2.all?d2.all[id]:d2.layers[id];
			if(d2.layers)el2.style=el2;
			el2.sP=function(x,y){this.style.left=x+'px';this.style.top=y+'px';};
			el2.x = startX2;
			el2.y = startY2;
			return el2;
		}
		window.stayTopLeft2=function()
		{
			if (document.body.clientWidth < 980)
			{
				ftlObj2.x = -110;ftlObj2.y = 0;	ftlObj2.sP(ftlObj2.x, ftlObj2.y);
			}
			else
			{
			if (document.documentElement && document.documentElement.scrollTop)
				var pY2 = ns2 ? pageYOffset : document.documentElement.scrollTop;
			else if (document.body)
				var pY2 = ns2 ? pageYOffset : document.body.scrollTop;

			if (document.body.scrollTop > 71){startY2 = 3} else {startY2 = 71};

			if (document.body.clientWidth <= 1024)
			{
				ftlObj2.x = 110;ftlObj2.y += (pY2 + startY2 - ftlObj2.y)/32;	ftlObj2.sP(ftlObj2.x, ftlObj2.y);
			}
			else if(document.body.clientWidth >1024)
			{
				ftlObj2.x = 110;ftlObj2.y += (pY2 + startY2 - ftlObj2.y)/32;	ftlObj2.sP(ftlObj2.x, ftlObj2.y);
			}
			else
			{						
			ftlObj2.x  = startX2;
			ftlObj2.y += (pY2 + startY2 - ftlObj2.y)/32;
			ftlObj2.sP(ftlObj2.x, ftlObj2.y);
			}
			}
			setTimeout("stayTopLeft2()", 1);
		}
		ftlObj2 = ml2("divAdLeft");
		stayTopLeft2();	
	}
	function ShowAdDiv()
	{	
		var objAdDivLeft  = document.getElementById("divAdLeft");
		var objAdDivRight = document.getElementById("divAdRight");
		if (document.body.clientWidth < 980)
		{
			objAdDivLeft.style.left  = - 110;
			objAdDivRight.style.left = - 110;
		}
		else
		{
			objAdDivLeft.style.left  = 110;
			objAdDivRight.style.left = document.body.clientWidth - 110;
		}
		FloatTopDiv();
		FloatTopDiv2();
	}
	function resetForm(id) {
	$('#'+id).each(function(){
	        this.reset();
	});
}