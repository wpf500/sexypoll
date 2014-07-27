package controllers

import play.api.mvc.{Action, Controller}

import awscala._
import awscala.dynamodbv2._
import play.api.libs.json.{Writes, Json}

object Quiz extends Controller {
  implicit val client = DynamoDB.at(Region.EU_WEST_1)

  val questions = client.table("bb-questions").get
  val answers = client.table("bb-answers").get

  val attributeWrites = Writes[Attribute] { attribute =>
    Json.obj(attribute.name -> attribute.value.getS)
  }

  val itemWrites = Writes[Item] { item => Json.toJson(item.attributes) }

  def read(id: String) = Action {
    questions.get(id)
      .map(quiz => Ok(Json.toJson(quiz)))
      .getOrElse(NotFound)
  }

  def create = Action {
    Ok
  }
}
