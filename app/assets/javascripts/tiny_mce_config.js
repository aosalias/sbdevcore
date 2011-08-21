function init_tinymce() {
  tinyMCE.init({
    // General options
    mode : "none",
    theme : "advanced",
    plugins : "autoresize, paste",

    // Plugin Options
    paste_auto_cleanup_on_paste : true,
    paste_block_drop : true,
    paste_retain_style_properties : "none",
    paste_strip_class_attributes : "all",
    paste_remove_spans : true,
    paste_remove_styles : true,
    paste_text_sticky : true,
    
    // Theme options
    theme_advanced_buttons1 :  "bold, italic, underline, |, justifyleft, justifycenter, justifyright, justifyfull, |, bullist, numlist, |, outdent, indent, |, formatselect, fontsizeselect, fontselect, |, link, unlink, |, pastetext,pasteword,selectall, |,code, removeformat;",
    theme_advanced_buttons2 :  "",
    theme_advanced_buttons3 :  "",
    theme_advanced_fonts : 'Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats;',
    theme_advanced_blockformats : "h1, h2, h3, h4, p, blockquote"
  });
}