First create a user:
POST /api/model/user
{
    data: "whatever"
}

Get your quiz:
GET /api/model/quiz/:id
{
    ...
}

Submit answers:
POST /api/model/user/answer/:quiz_id
{
    "user_id": "whatever",
    "data": [question1, question2, question3, question4]
}

See how your results compare with others:
GET /api/user/results/:quiz_id
{
    []
}