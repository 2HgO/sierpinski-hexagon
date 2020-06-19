# sierpinski-hexagon

Inspired by [this same project](https://github.com/chidiwilliams/sierpinski-hexagon) by [@chidiwilliams](https://github.com/chidiwilliams)

A simulation of a Sierpiński Hexagon made by plotting the centroids of equilateral triangles on the sides of a hexagon.

## Requirements
* Docker (v18.03+)

To check it out, clone the repo and run the either of the following commands from the root directory
```bash
docker-compose up --build
```

or

```bash
docker run --rm -p 55099:8000 $(docker build -q .)
```

The project should be running at [sierpinski-hexagon](http://localhost:8000/src/Main.elm)