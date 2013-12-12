/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	//config.protectedSource.push(/<span.*?><\/span>/g);
	config.defaultLanguage = "cn";
	config.language = "cn";
	config.filebrowserImageWindowWidth = 640;
	config.filebrowserImageWindowHeight = 480;
	config.pasteFromWordIgnoreFontFace = true;
	config.pasteFromWordRemoveStyle = true;
	config.forcePasteAsPlainText = true;
	//config.forcePasteAsPlainText = false;
	//config.pasteFromWordKeepsStructure = false;
	//config.pasteFromWordRemoveStyle = false;
	//config.pasteFromWordRemoveFontStyles = false;
	config.enterMode = CKEDITOR.ENTER_BR;
	
};

CKEDITOR.on( 'instanceReady', function( ev ) { with (ev.editor.dataProcessor.writer) {
	setRules("p", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("h1", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("h2", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("h3", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("h4", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("h5", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("div", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("table", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("tr", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("td", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("iframe", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("li", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("ul", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); 
	setRules("ol", {indent : false, breakAfterOpen : false, breakBeforeClose : false} ); } 
	});