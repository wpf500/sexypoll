$.getJSON("static/test/quiz.json", function (quiz) {
    quiz.current = window.localStorage['current'] || 0;

    var ractive = new Ractive({
        'el': '#container',
        'template': '#template',
        'data': quiz
    });

    $('.chart').highcharts({
        'chart': {
            'type': 'pie'
        },
        'title': {
            'text': null
        },
        'series': [{
            'type': 'pie',
            'name': 'blah',
            'data': []
        }]
    });

    var chart = $('.chart').highcharts();

    function update() {
        var slide = quiz.questions[0];

        var data = slide.answers.map(function (answer) {
            return [answer, Math.random()];
        });
        chart.series[0].setData(data);

        ractive.update();
        window.localStorage['current'] = quiz.current;
    }

    ractive.on('next', function () {
        if (quiz.current <= quiz.questions.length) {
            quiz.current++;
            update();
        }
    });

    ractive.on('prev', function () {
        if (quiz.current > 0) {
            quiz.current--;
            update();
        }
    });

    update();
});
