import { LogBox, Text, TouchableOpacity, View } from 'react-native';
import styles from './components/styles'; // ✅ Importer les styles

LogBox.ignoreAllLogs(); // ✅ Désactive tous les messages LogBox

export default function App() {
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Bienvenue dans mon app React Native !</Text>
      <TouchableOpacity style={styles.button}>
        <Text style={styles.buttonText}>Clique ici</Text>
      </TouchableOpacity>
    </View>
  );
}
