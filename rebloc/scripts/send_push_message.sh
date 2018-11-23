#!/bin/bash

FCM_SERVER_KEY="AAAADfnddEM:APA91bG_pvW3aVzS3UZsMb5A5msVWiCSjEcuVRdPbScyoQ4R35z9MEj3vm58TF3mlMH4zZdetta8TFpEaXA9yCYCv0bqTiocWaPg5USBofuHs0ZP-Qyrhw07C3_SVzyxbKvUBMQkIDD-"
FCM_TOKEN=$1
TITLE=$2
BODY=$3

if [[ -z "$FCM_TOKEN" ]]; then
  FCM_TOKEN="dfVd9KseG-A:APA91bGoHFQGXGrwAmnC6I6BIoIcj3KMjmaeM6AEr3uyEauiUd5_nfLE_UE0GElsdtm8rTwrXL6BsMhO1hk6sbG-ZTwd8Yt6Yu3aex26qR34a1vo2It3bWcNN8VHH4PSnWH0bOcjiCOn"
fi

if [[ -z "$TITLE" ]]; then
  TITLE="Achievement"
fi

if [[ -z "$BODY" ]]; then
  BODY="no body"
fi

DATA=$(cat <<DATA_EOF
{
  "data": {
    "click_action": "FLUTTER_NOTIFICATION_CLICK"
    "body": "$BODY",
    "title": "$TITLE",
    "id": "1",
    "status": "done"
  },
  "notification": {
    "body": "$BODY",
    "title": "$TITLE",
  },
  "priority": "high",
  "to": "$FCM_TOKEN"
}
DATA_EOF)

curl \
  https://fcm.googleapis.com/fcm/send \
  -X POST \
  -H "Authorization: key=$FCM_SERVER_KEY" \
  -H "Content-Type:application/json" \
  -d "$DATA"
