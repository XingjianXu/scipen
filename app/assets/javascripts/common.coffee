#= require js-routes
#= require codemirror/lib/codemirror
#= require codemirror/mode/markdown/markdown
#= require codemirror/mode/xml/xml
#= require codemirror/addon/edit/continuelist
#= require codemirror/addon/edit/matchbrackets
#= require codemirror/addon/edit/closebrackets
#= require semantic-ui/dropdown
#= require semantic-ui/checkbox
#= require semantic-ui/transition

$ ->
  $('.ui.checkbox').checkbox()
  $('.ui.dropdown').dropdown()

  el_article_source = document.getElementById('article_source')
  if el_article_source
    article_editor = CodeMirror.fromTextArea el_article_source,
      lineNumbers: true
      mode: 'markdown'
      viewportMargin: Infinity
      lineWrapping: true
      tabSize: 2
      autofocus: true
      extraKeys:
        'Cmd-I': (cm) ->
          if cm.getSelection().length == 0
            cursor = cm.getCursor()
            cursor.ch += 1
          cm.replaceSelection('_'+cm.getSelection()+'_')
          if cursor
            cm.setCursor(cursor)
        'Cmd-B': (cm) ->
          if cm.getSelection().length == 0
            cursor = cm.getCursor()
            cursor.ch += 2
          cm.replaceSelection('__'+cm.getSelection()+'__')
          if cursor
            cm.setCursor(cursor)
        'Cmd-L': (cm) ->
          if cm.getSelection().length == 0
            cursor = cm.getCursor()
            cursor.ch += 1
          cm.replaceSelection('['+cm.getSelection()+']()')
          if not cursor
            cursor = cm.getCursor()
            cursor.ch -= 1
          cm.setCursor(cursor)
