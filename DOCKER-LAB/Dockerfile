    FROM ubuntu
    RUN apt-get update
    # RUN mkdir labels_cd
    HEALTHCHECK --interval=5s --timeout=3s --retries=2 CMD cd ./labels_cd || exit 1