var apiURL = 'http://ancient-chamber-5314.herokuapp.com/api'
var quizId = '53c5158399024d3a59000001'

var userFuture = window.localStorage['userId'] ? $.noop() : $.post(apiURL + '/users');
var answers = (window.localStorage['answers'] || '').split('|');

var quizFuture = $.getJSON(apiURL + '/quizzes/' + quizId);
var articlesFuture = $.getJSON('http://beta.content.guardianapis.com/search?api-key=gu-hackday-2014&tag=politics/scottish-independence&show-fields=thumbnail,byline&page-size=5');

$.when(userFuture, quizFuture, articlesFuture).done(function(user, quiz, articles) {
    var userId = window.localStorage['userId'] || user[0]._id;
    window.localStorage['userId'] = userId;

    quiz = quiz[0];
    quiz.current = window.localStorage['current'] || 0;
    quiz.articles = articles[0].response.results;
    quiz.numbers = ['', '', '', ' two', ' three'];

    var ractive = new Ractive({
        'el': '#container',
        'template': '#template',
        'data': quiz
    });

    $('.chart').highcharts({
        'chart': {
            'type': 'pie',
            'height': 300
        },
        'tooltip': {
            'enabled': false
        },
        'colors': ['#00528C', '#DFDFDF', '#C9C9C9'],
        'title': {
            'text': null
        },
        'series': [{
            'type': 'pie',
            'data': []
        }]
    });

    var chart = $('.chart').highcharts();

    window.onresize = function () {
        window.parent.document.getElementById('poll').style.height = $('#container').outerHeight() + 'px';
    }

    function update(results) {
        var future;
        if (quiz.current > 0) {
            future =
                $.getJSON(apiURL + '/users/' + userId + '/results/' + quizId + '/' + quiz.current, function (results) {
                    quiz.total = 0;
                    var data = $.map(quiz.questions[0].answers, function (key) {
                        var value = results[key] || 0;
                        quiz.total += value;
                        return [{
                            'name': key,
                            'y': value,
                            'color': key == answers[0] ? '#00528C' : '#C9C9C9'
                        }];
                    });
                    quiz.yours = results[answers[0]];
                    chart.series[0].setData(data);
                });
        } else {
            future = $.noop();
        }

        $.when(future).done(function () {
            ractive.update();
            window.localStorage['current'] = quiz.current;
            window.localStorage['answers'] = answers.join('|');
            window.onresize();
        });
    }

    ractive.on('next', function (evt) {
        if (quiz.current < quiz.questions.length) {
            answers[quiz.current] = evt.context;
            $.post(apiURL + '/users/' + userId + '/answers', {
                'data': JSON.stringify({
                    'quiz_id': quizId,
                    'user_answers': answers
                })
            }, function () {
                quiz.current++;
                update();
            });
        }
    });

    ractive.on('prev', function () {
        if (quiz.current > 0) {
            quiz.current--;
            update();
        }
    });

    setInterval(update, 10000);
    update();
});
