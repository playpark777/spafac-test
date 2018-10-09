$ ->
  $('.add-identification-attachment').click ->
    li_count = $("ul.list-unstyled.identification-attachments>li").size() + 1

    input = document.createElement('input')
    input.setAttribute('type', 'file')
    input.setAttribute('id', "identification_image" + li_count)
    input.setAttribute('name', "identification[image" + li_count + "]")
    input.setAttribute('class', 'row-space-top-2-file')

    $('ul.list-unstyled.identification-attachments').append('<li>' + input.outerHTML + '</li>')

    if li_count >= 3
      $(this).remove()

