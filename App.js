import React, { useEffect, useState } from "react";
import { SafeAreaView, Text, NativeModules, Image } from "react-native";
import * as FileSystem from "expo-file-system";
import { Asset } from "expo-asset";

const App = () => {
  const [image, setImage] = useState("");

  const getOverlayImage = async () => {
    const { MergeImages } = NativeModules;

    const overlayAsset = Asset.fromModule(
      require("./images/testOverlay.png")
    );

    await overlayAsset.downloadAsync();

    const guestPhoto = Asset.fromModule(
      require("./images/sampleUpload.jpeg")
    );

    await guestPhoto.downloadAsync();
    try {
      console.log(guestPhoto);
      var guestImage = await FileSystem.readAsStringAsync(guestPhoto.localUri, {
        encoding: FileSystem.EncodingType.Base64,
      });

      console.log(guestImage);

      var overlayImage = await FileSystem.readAsStringAsync(overlayAsset.localUri, {
        encoding: FileSystem.EncodingType.Base64,
      });

      await MergeImages.applyOverlay(
        guestImage,
        overlayImage,
        (mergedImageBase64String) => {
          console.log(mergedImageBase64String);
          setImage(mergedImageBase64String);
        }
      );
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    getOverlayImage();
  }, []);

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <Text>Overlayed Image!</Text>
      {image !== "" && (
        <Image
          source={{ uri: `data:image/png;base64,${image}` }}
          style={{ width: 300, height: 400, resizeMode: "contain" }}
        />
      )}
    </SafeAreaView>
  );
};

export default App;
