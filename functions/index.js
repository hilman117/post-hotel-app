/* eslint-disable no-unused-vars */
/* eslint-disable no-inner-declarations */
try {
  /* eslint-disable require-jsdoc */
  /* eslint-disable no-undef */
  /* eslint-disable max-len */
  console.log("Starting script...");
  const functions = require("firebase-functions");
  const admin = require("firebase-admin");
  const axios = require("axios");
  const cors = require("cors")({origin: true});
  const {v4: uuidv4} = require("uuid");

  admin.initializeApp();

  const fcmApiKey = "AAAAcZoC9wI:APA91bFjuqIj--eZrTJGEJozCvlhSTSvCt1Aohba_EKqsu0msJcGrRL4A1Ou8PoF6GdK1_fX9o6CHUVz1LA6Re43AQsT-lkG2lKCdnvQ6EOQVC-bdIuM97GHME8yG-714OvP_q5b3aSi";


  exports.subscribeToTopic = functions.https.onRequest((req, res) => {
    cors(req, res, async () => {
      const {token, topic} = req.body;

      if (!token || !topic) {
        return res.status(400).send("Missing token or topic");
      }

      try {
        const response = await admin.messaging().subscribeToTopic(token, topic);
        console.log("Successfully subscribed:", response);
        return res.status(200).send("Successfully subscribed");
      } catch (error) {
        console.error("Subscription failed:", error.message);
        return res.status(500).send("Subscription failed to ${topic}");
      }
    });
  });


  exports.unsubscribeFromTopic = functions.https.onRequest((req, res) => {
    cors(req, res, async () => {
      const {token, topic} = req.body;

      if (!token || !topic) {
        return res.status(400).send("Missing token or topic");
      }

      try {
        const response = await admin.messaging().unsubscribeFromTopic(token, topic);
        console.log("Successfully unsubscribed:", response);
        return res.status(200).send("Successfully unsubscribed");
      } catch (error) {
        console.error("Unsubscription failed:", error.message);
        return res.status(500).send(`Unsubscription failed from ${topic}`);
      }
    });
  });


  // Reusable function
  async function sendNotifToTopic(topic, title, body, id, collection, image, status, notifType) {
    if (!topic || !id || !collection) {
      throw new Error("Missing required notification fields");
    }

    const message = {
      // "notification": {
      //   title: title,
      //   body: body,
      // },
      "topic": topic,
      "data": {
        id: id,
        collection: collection,
        image: image || "",
        status: status || "",
        title: title,
        body: body,
        notifType: notifType,
        topic: topic,
      },
      "android": {
        priority: "high",
      },
      "apns": {
        headers: {
          "apns-priority": "10",
        },
        payload: {
          aps: {
            "content-available": 1,
          },
        },
      },
    };

    try {
      const response = await admin.messaging().send(message);
      console.log("✅ Notification sent to topic:", topic, response);
      return response;
    } catch (error) {
      console.error("❌ Error sending topic notification:", error);
      throw error;
    }
  }


  async function tasksEscalate({
    hotelname,
    idTask,
    topic,
    listName,
    sendTo,
    senderName,
    title,
    location,
    index,
    uniqueTaskName,
    time,
    image,
  }) {
    console.log("tasksEscalate started");

    const taskSnapshot = await admin.firestore()
        .collection("Hotel List")
        .doc(hotelname)
        .collection("tasks")
        .doc(idTask)
        .get();

    if (!taskSnapshot.exists) {
      console.log("Task document does not exist.");
      return;
    }

    const taskData = taskSnapshot.data();
    const currentStatus = taskData.status || "";
    console.log("Current task status:", currentStatus);

    if (currentStatus !== "New" && currentStatus !== "ESC") {
      console.log(`Task ${idTask} cancellation logic here if applicable.`);
      return;
    } else {
      console.log("Processing data to Firestore");

      const commentElement = {
        timeSent: time,
        accepted: "",
        assignTask: "",
        assignTo: "",
        commentBody: "",
        commentId: uuidv4(),
        description: "",
        esc: String(index),
        imageComment: [],
        sender: "POST",
        senderemail: "",
        colorUser: "0xFF1B5E20",
        setDate: "",
        setTime: "",
        time: time,
        titleChange: "",
        newlocation: "",
        hold: "",
        resume: "",
        scheduleDelete: "",
      };

      const updateData = {
        subscriberToken: admin.firestore.FieldValue.arrayUnion(topic),
        assigned: admin.firestore.FieldValue.arrayUnion(...listName),
        status: "ESC",
        receiver: "POST",
        registeredTask: admin.firestore.FieldValue.arrayUnion(uniqueTaskName),
        comment: admin.firestore.FieldValue.arrayUnion(commentElement),
      };

      console.log("updateData:", JSON.stringify(updateData, null, 2));

      for (const key in updateData) {
        if (Array.isArray(updateData[key])) {
          for (const element of updateData[key]) {
            console.log(`Element being added to ${key}:`, element);
            if (Array.isArray(element)) {
              console.error(`Invalid nested array element for field ${key}:`, element);
              return;
            }
          }
        }
      }

      await admin.firestore()
          .collection("Hotel List")
          .doc(hotelname)
          .collection("tasks")
          .doc(idTask)
          .update(updateData);

      console.log("Firestore update completed.");

      try {
        console.log("Attempting to send notification...");
        await sendNotifToTopic(
            topic,
            `New ${sendTo}`,
            `${senderName} has sent new request, and escalated to you: "${title}" - "${location}"`,
            idTask,
            "tasks",
            image,
            "ESC",
            "ESC",
        );
        console.log(`Notification sent to ${topic}`);
      } catch (e) {
        console.log("Failed to send notification:", e);
      }

      console.log("tasksEscalate finished");
    }
  }

  async function reminderSchedule({hotelName, taskData, timing}) {
    console.log("Executing another function as setTime is not empty.");
    console.log(timing);

    const commentElement = {
      timeSent: timing || "",
      accepted: "",
      assignTask: "",
      assignTo: "",
      commentBody: "This request should be delivered in 0 minute",
      commentId: uuidv4(),
      description: "",
      esc: "",
      imageComment: [],
      sender: "POST",
      senderemail: "",
      colorUser: "0xFF1B5E20",
      setDate: "",
      setTime: "",
      time: timing || "",
      titleChange: "",
      newlocation: "",
      hold: "",
      resume: "",
      scheduleDelete: "",
    };

    const updateData = {
      comment: admin.firestore.FieldValue.arrayUnion(commentElement),
    };

    console.log("updateData:", JSON.stringify(updateData, null, 2));

    for (const key in updateData) {
      if (Array.isArray(updateData[key])) {
        for (const element of updateData[key]) {
          console.log(`Element being added to ${key}:`, element);
          if (Array.isArray(element)) {
            console.error(`Invalid nested array element for field ${key}:`, element);
            return;
          }
        }
      }
    }

    await admin.firestore()
        .collection("Hotel List")
        .doc(hotelName)
        .collection("tasks")
        .doc(taskData.id)
        .update(updateData);

    console.log("Update completed in anotherFunction.");

    try {
      console.log("Attempting to send notification...");
      await sendNotifToTopic(
          taskData.subscriberToken[0],
          `REMINDER ${taskData.sendTo}`,
          `"${taskData.title}" - "${taskData.location}" should be delivered in 0 minute`,
          taskData.id,
          "tasks",
          taskData.image[0],
          "New",
      );
      console.log(`Notification sent to ${taskData.subscriberToken[0]}`);
    } catch (e) {
      console.log("Failed to send notification:", e);
    }
  }

  function formatTime(date) {
    const pad = (number) => (number < 10 ? `0${number}` : number);
    const padMilliseconds = (number) => {
      // Ensure milliseconds are exactly three digits
      return String(number).padStart(3, "0");
    };

    const year = date.getFullYear();
    const month = pad(date.getMonth() + 1);
    const day = pad(date.getDate());
    const hours = pad(date.getHours());
    const minutes = pad(date.getMinutes());
    const seconds = pad(date.getSeconds());
    const milliseconds = padMilliseconds(date.getMilliseconds());

    return `${year}-${month}-${day}T${hours}:${minutes}:${seconds}.${milliseconds}`;
  }

  function parseDateTime(dateTimeString) {
    // Split the date and time parts
    const [datePart, timePart] = dateTimeString.split(" ");

    // Split the date parts
    const [year, month, day] = datePart.split("-").map(Number);

    // Split the time parts
    const [hours, minutes, seconds] = timePart.split(":").map((part) => {
      const [whole, fraction] = part.split(".");
      return fraction ? Number(`${whole}.${fraction}`) : Number(whole);
    });

    return new Date(year, month - 1, day, hours, minutes, seconds);
  }

  exports.escalateTasks = functions.pubsub.schedule("every 1 minutes").onRun(async (context) => {
    const db = admin.firestore();
    const hotelCollection = "Hotel List";
    const tasksCollection = "tasks";

    try {
      const hotelsQuerySnapshot = await db.collection(hotelCollection).get();
      const hotelNames = hotelsQuerySnapshot.docs.map((doc) => doc.data().hotelName);
      console.log(hotelNames);

      for (const hotelName of hotelNames) {
        // Query for tasks with status "New" or "ESC"
        const statusQuerySnapshot = await db
            .collection(hotelCollection)
            .doc(hotelName)
            .collection(tasksCollection)
            .where("status", "in", ["New", "ESC"])
            .get();

        // Query for tasks where setTime is not empty and the status is not close
        const setTimeQuerySnapshot = await db
            .collection(hotelCollection)
            .doc(hotelName)
            .collection(tasksCollection)
            .where("setTime", "!=", "")
            .get();

        // Combine results from both queries
        const combinedTasks = new Map();

        statusQuerySnapshot.forEach((doc) => {
          combinedTasks.set(doc.id, doc);
        });

        setTimeQuerySnapshot.forEach((doc) => {
          combinedTasks.set(doc.id, doc);
        });

        // Process the combined tasks
        for (const taskDoc of combinedTasks.values()) {
          const taskData = taskDoc.data();

          if (!taskData.setTime) {
            const listDeptSnapshot = await db
                .collection(hotelCollection)
                .doc(hotelName)
                .collection("Department")
                .get();
            const listDept = listDeptSnapshot.docs.map((doc) => doc.data());

            const localListIndex = [];
            let localListReceiverName = [];
            let localTopic = "";
            const departements = listDept;

            try {
              console.log("starts.........");
              const dept = departements.find((element) => element.departement === taskData.sendTo);

              const receivingUser = dept.receivingUser || [];
              console.log("Receiving Users:", receivingUser);

              for (const user of receivingUser) {
                const triggeredMinute = user.triggeredMinute;
                if (triggeredMinute != null) {
                  localListIndex.push(parseInt(triggeredMinute));
                }
              }
              localListIndex.sort();
              console.log("Sorted listIndex:", localListIndex);

              if (localListIndex.length > 0 && localListIndex.length === receivingUser.length) {
                for (let i = 0; i < localListIndex.length; i++) {
                  if (localListIndex[i] > 0) {
                    const triggeredMinute = localListIndex[i];
                    const receivingUserEntry = receivingUser.find((user) => parseInt(user.triggeredMinute) === triggeredMinute);

                    localTopic = receivingUserEntry.id;
                    const delay = triggeredMinute;
                    const uniqueTaskName = localTopic + taskDoc.id;

                    console.log(`Processing index ${i}, triggeredMinute ${delay}, uniqueTaskName ${uniqueTaskName}`);

                    const registeredTask = taskData.registeredTask || [];
                    if (registeredTask.includes(uniqueTaskName)) {
                      console.log(`Task ${uniqueTaskName} already registered`);
                    } else {
                      console.log(`Scheduling task with topic: ${uniqueTaskName} and delay: ${delay} minutes`);

                      localListReceiverName = receivingUserEntry.receiver;
                      console.log("Receivers:", localListReceiverName);

                      try {
                        // Get current time in UTC
                        const currentTime = Date.now();

                        // Convert taskData.time to local time
                        const taskDateTime = taskData.time.toDate(); // ✅ ini aman // Assuming taskData.time is in UTC or another timezone
                        const scheduledTime = new Date(taskDateTime.getTime() + delay * 60 * 1000);
                        const formattedScheduledTime = scheduledTime.toISOString();
                        console.log(`Current time: ${new Date(currentTime).toISOString()}, Scheduled time: ${formattedScheduledTime}`);

                        // Check if it's time to escalate the task
                        if (currentTime >= scheduledTime.getTime()) {
                          await tasksEscalate({
                            hotelname: hotelName,
                            idTask: taskDoc.id,
                            time: formattedScheduledTime,
                            topic: localTopic,
                            listName: localListReceiverName,
                            sendTo: taskData.sendTo,
                            senderName: taskData.sender,
                            title: taskData.title,
                            location: taskData.location,
                            index: triggeredMinute,
                            uniqueTaskName: uniqueTaskName,
                            image: taskData.image ? taskData.image[0] : "",
                          });

                          console.log(`Task with topic: ${uniqueTaskName} and delay: ${delay} minutes registered successfully`);
                        } else {
                          console.log(`Task with topic: ${uniqueTaskName} is not yet ready for escalation.`);
                        }
                      } catch (error) {
                        console.error("Error during task escalation:", error);
                      }
                    }
                  }
                }
              }
            } catch (e) {
              console.error("Error processing department info:", e);
            }
          }
        }
      }
    } catch (error) {
      console.error("Error processing hotel tasks:", error);
    }
  });

  // const cors = require("cors")({origin: true});

  exports.sendNotifToTopic = functions.https.onRequest(async (req, res) => {
    try {
      cors(req, res, async () => {
        const {token, topic, data} = req.body;

        if (!token && !topic) {
          return res.status(400).json({error: "Missing target (token/topic)"});
        }

        const message = {
          "data": {
            ...data,
          },
          "android": {
            priority: "high",
          },
          "apns": {
            headers: {
              "apns-priority": "10",
            },
            payload: {
              aps: {
                "content-available": 1,
              },
            },
          },
          "webpush": {
            headers: {
              Urgency: "high",
            },
          },
        };

        if (token) {
          message.token = token;
        } else if (topic) {
          message.topic = topic;
        }

        const response = await admin.messaging().send(message);
        console.log("✅ Notification sent:", response);
        return res.status(200).json({success: true, response});
      });
    } catch (error) {
      console.error("❌ Error sending notification:", error);
      return res.status(500).json({success: false, error: error.message});
    }
  });
} catch (error) {
  console.error("Error in main function:", error);
}
