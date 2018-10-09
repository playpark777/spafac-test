$ ->
  if $('body').hasClass("listing_ngevents")
    delete_mode = false
    listing_id  = $('#calendar').data('listing_id')
    action_url  = '/listings/' + listing_id + '/listing_ngevents/'
    delete_all_url  = '/listings/' + listing_id + '/listing_ngevents/delete_all_day'

    # Create Event
    createEvent = (start, end) ->
      if delete_mode == true
        data = make_send_data(start, end)
        $.ajax
          type: 'POST'
          url: delete_all_url
          data: JSON.stringify({'event' : data})
          dataType: 'json'
          contentType: 'application/json'
          success: ->
            calendar.fullCalendar 'refetchEvents'
            return false
          error: ->
            calendar.fullCalendar 'refetchEvents'
      else
        data = make_send_data(start,end)
        $.ajax
          type: 'POST'
          url: action_url
          data: JSON.stringify({'event' : data})
          dataType: 'json'
          contentType: 'application/json'
          success: ->
            calendar.fullCalendar 'refetchEvents'
            return
          error: ->
            calendar.fullCalendar 'refetchEvents'
      return

    #送信データ作成用
    make_send_data = (start, end) ->
      event_send_data = []
      loop_cnt = Math.floor((end.unix() - start.unix()) / 60 / 60 / 24)
      i = 0
      while i < loop_cnt
        start_clone = start.clone()
        # end_clone = start.clone()
        start_val = start_clone.add('days', i).add('hour', -9)
        end_val = start_clone.clone().add('hour', 9).endOf('day').add('hour', -9)
        event_send_data.push
          start_at: start_val._d
          end_at: end_val._d
        i++
      return event_send_data

    resizeEvent = (event, revertFunc) ->
      data =
        _method: 'PUT'
        event:
          start_at: event.start._d
          end_at: event.end._d
      $.ajax
        type: 'PUT'
        url: action_url + event.id
        data: data
        dataType: 'json'
        success: ->
          calendar.fullCalendar 'refetchEvents'
          return false
        error: ->
          calendar.fullCalendar 'refetchEvents'
      return false

    dropEvent = (event, revertFunc) ->
      data =
        _method: 'PUT'
        event:
          start_at: event.start._d
          end_at: event.end._d
      $.ajax
        type: 'PUT'
        url: action_url + event.id
        data: data
        dataType: 'json'
        success: ->
          calendar.fullCalendar 'refetchEvents'
          return false
        error: ->
          calendar.fullCalendar 'refetchEvents'
      return false

    removeEvent = (event, revertFunc) ->
      if delete_mode == true
        res = confirm I18n.t('js.calendar.remove_event.alert')
        if res == false
          return false
        data =
          _method: 'DELETE'
        $.ajax
          type: 'DELETE'
          url: action_url + event.id
          data: data
          dataType: 'json'
          success: ->
            calendar.fullCalendar 'refetchEvents'
            return false
          error: ->
            calendar.fullCalendar 'refetchEvents'
      else
        calendar.fullCalendar 'refetchEvents'
      return false

    calendar = $('#calendar').fullCalendar(
      header: {
        left: 'today prev,next title',
        center: '',
        right: ''
      },
      defaultView: 'month',
      # 時間の書式
      timeFormat: 'H(:mm)',
      # 列の書式
      columnFormat: {
          month: 'ddd',    # 月
          week: "d'('ddd')'", # 7(月)
          day: "d'('ddd')'" # 7(月)
      },
      # タイトルの書式
      titleFormat: {
          month: I18n.t('js.calendar.title_format.month'), # 2013年9月
          week: I18n.t('js.calendar.title_format.week'),   # 2013年9月7日 ～ 13日
          day: I18n.t('js.calendar.title_format.day')      # 2013年9月7日(火)
      },
      buttonText: {
        # prev: '',
        # next: '',
        prevYear: ' << ',
        nextYear: ' >> ',
        today: I18n.t('js.calendar.button_text.today'),
        month: I18n.t('js.calendar.button_text.month'),
        week: I18n.t('js.calendar.button_text.week'),
        day: I18n.t('js.calendar.button_text.day')
      },
      # 月名称
      monthNames: [
        I18n.t('js.calendar.month_names.jan'), I18n.t('js.calendar.month_names.feb'), I18n.t('js.calendar.month_names.mar'),
        I18n.t('js.calendar.month_names.apr'), I18n.t('js.calendar.month_names.may'), I18n.t('js.calendar.month_names.jun'),
        I18n.t('js.calendar.month_names.jul'), I18n.t('js.calendar.month_names.aug'), I18n.t('js.calendar.month_names.sep'),
        I18n.t('js.calendar.month_names.oct'), I18n.t('js.calendar.month_names.nov'), I18n.t('js.calendar.month_names.dec')
      ],
      # 月略称
      monthNamesShort: [
        I18n.t('js.calendar.month_names_short.jan'), I18n.t('js.calendar.month_names_short.feb'), I18n.t('js.calendar.month_names_short.mar'),
        I18n.t('js.calendar.month_names_short.apr'), I18n.t('js.calendar.month_names_short.may'), I18n.t('js.calendar.month_names_short.jun'),
        I18n.t('js.calendar.month_names_short.jul'), I18n.t('js.calendar.month_names_short.aug'), I18n.t('js.calendar.month_names_short.sep'),
        I18n.t('js.calendar.month_names_short.oct'), I18n.t('js.calendar.month_names_short.nov'), I18n.t('js.calendar.month_names_short.dec')
      ],
      # 曜日名称
      dayNames: [
        I18n.t('js.calendar.day_names.sun'), I18n.t('js.calendar.day_names.mon'), I18n.t('js.calendar.day_names.tue'),
        I18n.t('js.calendar.day_names.wed'), I18n.t('js.calendar.day_names.thu'), I18n.t('js.calendar.day_names.fri'),
        I18n.t('js.calendar.day_names.sat')
      ],
      # 曜日略称
      dayNamesShort: [
        I18n.t('js.calendar.day_names_short.sun'), I18n.t('js.calendar.day_names_short.mon'), I18n.t('js.calendar.day_names_short.tue'),
        I18n.t('js.calendar.day_names_short.wed'), I18n.t('js.calendar.day_names_short.thu'), I18n.t('js.calendar.day_names_short.fri'),
        I18n.t('js.calendar.day_names_short.sat')
      ],
      contentHeight: 500,
      slotEventOverlap: false,
      events: action_url.replace(/\/$/,'') + '.json',
      selectable: true,
      selectHelper: true,
      ignoreTimezone: false,
      editable: true,
      select: createEvent,
      eventClick: removeEvent,
      eventResize: resizeEvent,
      eventDrop: dropEvent,
    )

    # delete_btn
    $('#delete_mode').on 'click', ->
      $(this).empty()
      if delete_mode == false
        $(this).append('<button id="no_delete">' + I18n.t("js.calendar.delete_button.on_mode.label") + '</button>')
        $('.fc-toolbar').append('<div class="calendar-alert">' + I18n.t("js.calendar.delete_button.on_mode.alert") + '</div>')
        $('.fc-view-container').addClass('delete-mode')
        delete_mode = true
      else
        $(this).append('<button id="delete_btn">' + I18n.t("js.calendar.delete_button.off_mode.label") + '</button>')
        $('.fc-view-container').removeClass('delete-mode')
        $('.calendar-alert').remove()
        delete_mode = false
      return
    return
