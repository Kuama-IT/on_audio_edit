/*
Author: Lucas Josino
Github: https://github.com/LucasPJS
Plugin: on_audio_edit
Homepage: https://github.com/LucasPJS/on_audio_edit
Copyright: © 2021, Lucas Josino. All rights reserved.
License: https://github.com/LucasPJS/on_audio_edit/blob/main/LICENSE
*/

part of on_audio_edit;

///Interface and Main method for use on_audio_edit
class OnAudioEdit {
  //Dart <-> Kotlin communication
  static const String _CHANNEL_ID = "com.lucasjosino.on_audio_edit";
  static const MethodChannel _channel = const MethodChannel(_CHANNEL_ID);

  /// Used to return unique song info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find specific audio data.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   Map<dynamic, dynamic> song = await OnAudioEdit().readAudio(data);
  ///   var songTitle = song["TITLE"];
  ///   var songArtist = song["ARTIST"];
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * Most audios have no information other than the [title] and [artist].
  /// * This method return a [Map<dynamic, dynamic>].
  Future<Map<dynamic, dynamic>> readAudio(String data) async {
    final Map<dynamic, dynamic> resultReadAudio =
        await _channel.invokeMethod("readAudio", {
      "data": data,
    });
    return resultReadAudio;
  }

  /// Used to return all possible info of a unique song.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find specific audio data.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   Map<dynamic, dynamic> song = await OnAudioEdit().readAudio(data);
  ///   var songTitle = song["TITLE"];
  ///   var songArtist = song["ARTIST"];
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * Most audios have no information other than the [title] and [artist].
  /// * This method return a [Map<dynamic, dynamic>].
  Future<Map<dynamic, dynamic>> readAllAudio(String data) async {
    final Map<dynamic, dynamic> resultReadAudio =
        await _channel.invokeMethod("readAllAudio", {
      "data": data,
    });
    return resultReadAudio;
  }

  /// Used to return multiples songs info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   List AudiosTagModel> song = await OnAudioEdit().readAudios(allData);
  ///   ...
  ///   var songInfo = song[0].title;
  ///   var songInfo2 = song[1].title;
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * Most audios have no information other than the [title] and [artist].
  Future<List<AudiosTagModel>> readAudios(List<String> data) async {
    final List<dynamic> resultReadAudio =
        await _channel.invokeMethod("readAudios", {
      "data": data,
    });
    return resultReadAudio.map((e) => AudiosTagModel(e)).toList();
  }

  /// Used to return unique song tag.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  /// * [tag] is use to specify what tag you want.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   String title = await OnAudioEdit().readSingleAudioTag(data, TagsType.TITLE);
  ///   print(title); // Ex: Heavy, California
  ///   ...
  ///   String artist = await OnAudioEdit().readSingleAudioTag(data, TagsType.ARTIST);
  ///   print(artist); // Ex: Jungle
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * Most audios have no information other than the [title] and [artist].
  Future<String> readSingleAudioTag(String data, TagsType tag) async {
    final String resultSingleAudioTag =
        await _channel.invokeMethod("readSingleAudioTag", {
      "data": data,
      "tag": tag.index,
    });
    return resultSingleAudioTag;
  }

  /// Used to return specifics tags from song.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  /// * [tags] is use to specify what tags you want.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   List<TagsType> tags = [
  ///     TagsType.TITLE,
  ///     TagsType.ARTIST
  ///   ];
  ///   var songSpecifics = await OnAudioEdit().readSpecificsAudioTags(data, tags);
  ///   ...
  ///   var songTitle = songSpecifics["TITLE"];
  ///   var songArtist = songSpecifics["ARTIST"];
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * Most audios have no information other than the [title] and [artist].
  /// * This method return a [Map<dynamic, dynamic>].
  Future<Map<dynamic, dynamic>> readSpecificsAudioTags(
      String data, List<TagsType> tags) async {
    List<int> tagsIndex = [];
    tags.forEach((it) {
      tagsIndex.add(it.index);
    });
    final Map<dynamic, dynamic> readSpecificsAudioTags =
        await _channel.invokeMethod("readSpecificsAudioTags", {
      "data": data,
      "tags": tagsIndex,
    });
    return readSpecificsAudioTags;
  }

  /// Used to edit song info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find specific audio data.
  /// * [tags] is used to define what tags and values you want edit.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   Map<TagsType, dynamic> tags = {
  ///     TagsType.TITLE: "New Title",
  ///     TagsType.ARTIST: "New Artist"
  ///   };
  ///   bool song = await OnAudioEdit().editAudio(data, tags);
  ///   print(song); //True or False
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * This method return true if audio has edited or false if don't.
  ///
  /// Super Important:
  /// * This method works normal in Android below 10,
  /// from Android 10 or above user will need to accept access in Folder.
  /// You can see this "Complex Permission" status using [complexPermissionStatus].
  /// By default when calling this method will open a new screen to user choose a folder,
  /// but you can anticipate the request using [requestComplexPermission].
  /// The request status and folder permission will be saved as persistent but
  /// if user uninstall the app, this permission will be removed.
  Future<bool> editAudio(String data, Map<TagsType, dynamic> tags) async {
    Map<int, dynamic> finalTags = {};
    tags.forEach((key, value) {
      finalTags[key.index] = value;
    });
    final bool resultEditAudio = await _channel.invokeMethod("editAudio", {
      "data": data,
      "tags": finalTags,
    });
    return resultEditAudio;
  }

  /// Used to edit multiples songs info.
  ///
  /// Parameters:
  ///
  /// * [data] is used for find multiples audios data.
  /// * [tags] is used to define what tags and values you want edit.
  ///
  /// Usage:
  ///
  /// ```dart
  ///   // Tags
  ///   List Map TagsType, dynamic>> tags = [];
  ///   Map<TagsType, dynamic> getTags = {
  ///     TagsType.TITLE: "New Title",
  ///     TagsType.ARTIST: "New Artist"
  ///   };
  ///   tags.add(getTags);
  ///
  ///   // Songs data
  ///   List String> data;
  ///   data.add(song1);
  ///   data.add(song2);
  ///   data.add(song3);
  ///   bool result = await OnAudioEdit().editAudios(data, tags);
  ///   print(result); //True or False
  /// ```
  ///
  /// Important:
  ///
  /// * Calling any method without [READ] and [WRITE] permission will throw a error.
  /// Use [permissionsStatus] to see permissions status.
  /// * This method return true if audio has edited or false if don't.
  ///
  /// Super Important:
  /// * This method works normal in Android below 10,
  /// from Android 10 or above user will need to accept access in Folder.
  /// You can see this "Complex Permission" status using [complexPermissionStatus].
  /// By default when calling this method will open a new screen to user choose a folder,
  /// but you can anticipate the request using [requestComplexPermission].
  /// The request status and folder permission will be saved as persistent but
  /// if user uninstall the app, this permission will be removed.
  Future<bool> editAudios(
      List<String> data, List<Map<TagsType, dynamic>> tags) async {
    List<Map<int, dynamic>> finalList = [];
    tags.forEach((it1) {
      Map<int, dynamic> finalTags = {};
      it1.forEach((key, value) {
        finalTags[key.index] = value;
      });
      finalList.add(finalTags);
    });
    final bool resultEditAudios = await _channel.invokeMethod("editAudios", {
      "data": data,
      "tags": finalList,
    });
    return resultEditAudios;
  }

  // Future<bool> editSingleAudioTag(String data, TagsType tag) async {
  //   final bool resultSingleAudioTag =
  //       await _channel.invokeMethod("editSingleAudioTag", {
  //     "data": data,
  //     "tag": tag,
  //   });
  //   return resultSingleAudioTag;
  // }

  /// Used to edit audio artwork.
  ///
  /// Parameters:
  ///
  /// * [data] is used to find multiples audios data.
  /// * [openFilePicker] is used to define if folder picker will be open to user choose image.
  /// * [imagePath] is used to define image path, only necessary if [openFilePicker] is false.
  /// * [format] is used to define image type: [JPG], [JPEG] or [JPEG].
  /// * [size] is used to define image quality.
  /// * [description] is used to define artwork description.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * If return true edit works, else edit found a problem.
  /// * If [openFilePicker] is null, will be set to [true].
  /// * If [imagePath] is null, [openFilePicker] need to be true.
  /// * If [format] is null, will be set to [JPEG].
  /// * If [size] is null, will be set to [24].
  /// * If [description] is null, will be set to ["artwork"].
  Future<bool> editArtwork(String data,
      [bool? openFilePicker,
      String? imagePath,
      ArtworkFormat? format,
      int? size,
      String? description]) async {
    assert(
        openFilePicker == false || imagePath == null,
        "Cannot change artwork image without image.\n"
        "Set [openFilePicker] to true or give [imagePath] a correct path");
    final bool resultEditArt = await _channel.invokeMethod("editArtwork", {
      "data": data,
      "type": format != null ? format.index : ArtworkFormat.JPEG.index,
      "size": size ?? 24,
      "description": description ?? "artwork",
      "openFilePicker": openFilePicker ?? true,
      "imagePath": imagePath
    });
    return resultEditArt;
  }

  /// Used to check Android permissions status.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * If return true [READ] and [WRITE] permissions is Granted, else [READ] and [WRITE] is Denied.
  Future<bool> permissionsStatus() async {
    final bool resultStatus = await _channel.invokeMethod("permissionsStatus");
    return resultStatus;
  }

  /// Used to check Complex Android permissions status.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 10 or above.
  /// * If return true Complex Permission is Granted, else Complex Permission is Denied.
  Future<bool> complexPermissionStatus() async {
    final bool resultStatusComplex =
        await _channel.invokeMethod("complexPermissionStatus");
    return resultStatusComplex;
  }

  /// Used to request Complex Android permissions.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 10 or above.
  /// * If return true, Complex Permission was called, else Complex Permission was't called.
  Future<bool> requestComplexPermission() async {
    final bool resultRequestComplex =
        await _channel.invokeMethod("requestComplexPermission");
    return resultRequestComplex;
  }

  /// Used to reset Complex Android permissions.
  ///
  /// Important:
  ///
  /// * This method will always return a bool.
  /// * This method only works on Android 10 or above.
  /// * If return true, Complex Permission was reset, else Complex Permission was't reset.
  Future<bool> resetComplexPermission() async {
    final bool resultReset =
        await _channel.invokeMethod("resetComplexPermission");
    return resultReset;
  }

  /// Used to open image folder to user select image and return this image path.
  Future<String> getImagePath() async {
    final String resultImagePath = await _channel.invokeMethod("getImagePath");
    return resultImagePath;
  }

  /// Used to return a converted value from file length.
  int convertLengthToMb(int length) {
    int firstConvert = (length / 1024) as int;
    return (firstConvert / 1024) as int;
  }
}