import { Injectable } from "@nestjs/common";
import { asyncActionType } from "../enum/async.action.type.enum";
import {
  AsyncAction,
  AsyncOperationsInterface,
} from "./async-operations.interface";

@Injectable()
export class AsyncOperationsQueueService implements AsyncOperationsInterface {
  public async AddAction(action: AsyncAction): Promise<boolean> {
    var AWS = require("aws-sdk");
    var sqs = new AWS.SQS();
    var params = {};

    if (action.actionType === asyncActionType.Email) {
      params = {
        MessageBody: JSON.stringify(action.actionProps),
        QueueUrl:
          "https://sqs.us-east-1.amazonaws.com/302213478610/AsyncQueue"
      };
    }

    sqs.sendMessage(params, function (err, data) {
      if (err) {
        console.log("d1 Error", err);
      } else {
        console.log("d1 Success", data);
      }
    });
    return true;
  }
}
