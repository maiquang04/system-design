import pika, json, traceback


def upload(f, fs, channel, access):
    try:
        print("Begin put...")
        fid = fs.put(f)
        print("Finish put...")
    except Exception:
        traceback.print_exc()
        return "internal server error", 500

    message = {
        "video_fid": str(fid),
        "mp3_fid": None,
        "username": access["username"],
    }

    try:
        print("Begin publish...")
        channel.basic_publish(
            exchange="",
            routing_key="video",
            body=json.dumps(message),
            properties=pika.BasicProperties(
                delivery_mode=pika.spec.PERSISTENT_DELIVERY_MODE
            ),
        )
        print("Finish publish...")
    except Exception:
        traceback.print_exc()
        fs.delete(fid)
        return "internal server error", 500
