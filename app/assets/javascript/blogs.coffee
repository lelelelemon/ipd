# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->
    Array::unique = ->
      output = {}
      output[@[key]] = @[key] for key in [0...@length]
      value for key, value of output
    colorScale  =  (sorted_array) -> 
        results = {}
        start = 0.2
        end = 0.8
        scale = (end - start) / sorted_array.length
        for i in [0...sorted_array.length] 
            do (i) ->
                value = sorted_array[i]
                results[value] = "hsl(44, 86%," + (end - i * scale) * 100 + "%)"
        return results     
        
    getRandomColor = -> 
        letters = '0123456789ABCDEF'
        color = '#'
        numbers = [1,2,3,4,5,6]
        for i in numbers 
            do (i) ->
            color += letters[Math.floor(Math.random() * 16)]
        return color
    colors = ['#FFE5CC','#FFCC99','#FFB266','#FF9933','#CC6600']
    #cost = open('cost.txt', 'r')
    cost = [['span#user-num', '2.3', 'select count(*) from users'], ['span#blog-num', '64.4', 'select count(*) from blogs where category = admin'], ['div#blogs', '2.8', 'select * from blogs where cateogry = admin'], ['div#users','58.3', 'select * from users']]
    cost.sort (a, b) ->
        a[1] - b[1];
    time = cost.map (x) -> x[1]
    color_scale = colorScale(time)
    i = 0
    for c in cost
        do (c) ->
            id = c[0]
            t = c[1]
            q = c[2]
            color = color_scale[c[1]]
            #alert(color)
            i += 1
            pList = $(id + " p")
            if pList.length == 0
                $(id).css("background-color", color)
                $(id).on 'click', () ->
                    $(this).popover({trigger:'click', content:  t + 'ms\n' + q, template: '<div class="popover">'+ '<div class="popover-content" >'+'</div><div  align="center" class="popover-footer"><button type="button" class="btn btn-primary popover-submit">'+'<i class="icon-ok icon-white">Delete</i></button>&nbsp;</div></div>', placement:'right'});
 
            for par in pList
                do (par) ->
                    $(par).css("background-color", color)
                    $(par).on 'click', () ->
                        $(par).popover({trigger:'click', content:  t + 'ms\n' + q, template: '<div class="popover">'+ '<div class="popover-content" >'+'</div><div  align="center" class="popover-footer"><button type="button" class="btn btn-primary popover-submit">'+'<i class="icon-ok icon-white">Delete</i></button>&nbsp;</div></div>', placement:'right'});
