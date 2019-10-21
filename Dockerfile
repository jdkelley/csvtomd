# docker run --rm \
#     -it \
#     -v workdir:/scripts
#     jdkelley/csvtomd <csv-file-path.csv>
#

FROM jdkelley/bash
LABEL maintainer="jdkelley.oss@gmail.com"

COPY csvtomd.sh .

ENTRYPOINT [ "./csvtomd.sh" ]
