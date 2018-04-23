// Generated by CoffeeScript 1.10.0
(function() {
  jQuery(function($) {
    var c, colorScale, color_scale, colors, cost, getRandomColor, i, j, len, results1, time;
    Array.prototype.unique = function() {
      var j, key, output, ref, results1, value;
      output = {};
      for (key = j = 0, ref = this.length; 0 <= ref ? j < ref : j > ref; key = 0 <= ref ? ++j : --j) {
        output[this[key]] = this[key];
      }
      results1 = [];
      for (key in output) {
        value = output[key];
        results1.push(value);
      }
      return results1;
    };
    colorScale = function(sorted_array) {
      var end, fn, i, j, ref, results, scale, start;
      results = {};
      start = 0.2;
      end = 0.8;
      scale = (end - start) / sorted_array.length;
      fn = function(i) {
        var value;
        value = sorted_array[i];
        return results[value] = "hsl(44, 86%," + (end - i * scale) * 100 + "%)";
      };
      for (i = j = 0, ref = sorted_array.length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        fn(i);
      }
      return results;
    };
    getRandomColor = function() {
      var color, fn, i, j, len, letters, numbers;
      letters = '0123456789ABCDEF';
      color = '#';
      numbers = [1, 2, 3, 4, 5, 6];
      fn = function(i) {};
      for (j = 0, len = numbers.length; j < len; j++) {
        i = numbers[j];
        fn(i);
        color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
    };
    
    var Parameters =
    {
      'id': '124'
    };
    $.ajax({
        url: '/ipd/test/index',
        type: "GET",
        contentType: "application/json; charset=utf-8",
        data: Parameters ,
        dataType: "json",
        success: function (data) {

        },
        error: function (e) {

        }
    });
    colors = ['#FFE5CC', '#FFCC99', '#FFB266', '#FF9933', '#CC6600'];
    cost = [['span#user-num', '2.3', 'select count(*) from users'], ['span#blog-num', '64.4', 'select count(*) from blogs where category = admin'], ['div#blogs', '2.8', 'select * from blogs where cateogry = admin'], ['div#users', '58.3', 'select * from users']];
    cost.sort(function(a, b) {
      return a[1] - b[1];
    });
    time = cost.map(function(x) {
      return x[1];
    });
    color_scale = colorScale(time);
    i = 0;
    results1 = [];
    for (j = 0, len = cost.length; j < len; j++) {
      c = cost[j];
      results1.push((function(c) {
        var color, id, k, len1, pList, par, q, results2, t;
        id = c[0];
        t = c[1];
        q = c[2];
        color = color_scale[c[1]];
        i += 1;
        pList = $(id + " p");
        if (pList.length === 0) {
          $(id).css("background-color", color);
          $(id).on('click', function() {
            return $(this).popover({
              trigger: 'click',
              content: t + 'ms\n' + q,
              template: '<div class="popover">' + '<div class="popover-content" >' + '</div><div  align="center" class="popover-footer"><button type="button" class="btn btn-primary popover-submit">' + '<i class="icon-ok icon-white">Delete</i></button>&nbsp;</div></div>',
              placement: 'right'
            });
          });
        }
        results2 = [];
        for (k = 0, len1 = pList.length; k < len1; k++) {
          par = pList[k];
          results2.push((function(par) {
            $(par).css("background-color", color);
            return $(par).on('click', function() {
              return $(par).popover({
                trigger: 'click',
                content: t + 'ms\n' + q,
                template: '<div class="popover">' + '<div class="popover-content" >' + '</div><div  align="center" class="popover-footer"><button type="button" class="btn btn-primary popover-submit">' + '<i class="icon-ok icon-white">Delete</i></button>&nbsp;</div></div>',
                placement: 'right'
              });
            });
          })(par));
        }
        return results2;
      })(c));
    }
    return results1;
  });

}).call(this);
