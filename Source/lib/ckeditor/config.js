/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.toolbar = 'MyToolbar';

    config.toolbar_MyToolbar =
    [
        ['Source','-','Format','Font','FontSize','TextColor', 'BGColor'],
        ['Cut','Copy','Paste','PasteText','Print'],
        ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
        '/',
        ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['Link','Unlink','Anchor'],
        ['Table','Image','HorizontalRule','SpecialChar','Maximize','-','About']
    ];

	
    config.baseHref = 'http://www.buffalotours.com/';
	config.filebrowserUploadUrl = "/ckeditor/BTUpload.aspx";
};
