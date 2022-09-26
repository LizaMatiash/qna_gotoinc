import consumer from "./consumer"

if (/questions\/\d+/.test(window.location.pathname)) {
  consumer.subscriptions.create({ channel: "AnswerChannel", question_id: gon.question_id }, {
    connected() {
      console.log("Connected to Answers");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      if (data.type === 'answer') {

        data.is_file_attached = data.files.length;
        data.is_answer_owner = gon.user_id === data.answer.user_id;
        data.is_not_answer_owner = !(gon.user_id === data.answer.user_id);
        data.is_question_owner = gon.user_id === gon.question_owner_id;

        $('.answers').append(
          HandlebarsTemplates['answer'](data)
         );
        $('textarea#answer_body').val('')
      }
      else {
        if (data.resource === 'Question') {
          $('.question-comments').append(
            HandlebarsTemplates['comment'](data)
          );
        }
        else {
          $('.answer-comments').append(
            HandlebarsTemplates['comment'](data)
          );
        }
      }
    }
  });

}
else {
  consumer.subscriptions.create("QuestionsChannel", {
    connected() {
      console.log("Connected to Queestions");
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log("res");
      console.log(data);
      $('.question-list').append(
        HandlebarsTemplates['question'](data)
      );
    }
  });
}
