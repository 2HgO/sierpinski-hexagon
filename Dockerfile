FROM codesimple/elm:0.19

RUN mkdir -p /app /app/sierpinski-hexagon

WORKDIR /app/sierpinski-hexagon

COPY . .

CMD ["reactor"]