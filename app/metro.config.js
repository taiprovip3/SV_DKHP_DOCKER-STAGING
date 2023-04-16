module.exports = {
    resolver: {
      useJit: true,
      engine: {
        jsc: true,
        hermes: false
      },
      assetExts: ["db", "mp3", "ttf", "obj", "png", "jpg"],
    }
  };