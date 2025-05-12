import React, { useState } from "react";
import { SafeAreaView, StyleSheet } from "react-native";
import { GiftedChat } from "react-native-gifted-chat";

const ChatScreen = () => {
  const [messages, setMessages] = useState([]);

  const onSend = (newMessages = []) => {
    setMessages((previousMessages) =>
      GiftedChat.append(previousMessages, newMessages)
    );
  };

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <GiftedChat
        messages={messages}
        onSend={(messages) => onSend(messages)}
        user={{ _id: 1, name: "Ibrahime" }}
      />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    elevation: 4, // Pour Android
    boxShadow: "0px 4px 6px rgba(0, 0, 0, 0.1)", // Pour Web
  },
});


export default ChatScreen;
