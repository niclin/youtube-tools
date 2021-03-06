import consumer from "./consumer"

const DonateGoalChannel = consumer.subscriptions.create({ channel: "DonateGoalChannel", token: gon.donate_event_token }, {
  connected() {
    console.log("Connected to the chat room!");
  },

  disconnected() {
  },

  received(data) {
    const { goal_amount, total_amount } = data

    const percentage = (total_amount / goal_amount) * 100

    $("#total_amount").text(data.total_amount)
    $("#progress-bar").width(`${percentage}%`)
    $(".wheel-pointer").click()
  }
});

export default DonateGoalChannel