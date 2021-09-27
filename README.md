# README

https://eapp-bz.herokuapp.com/


```
git clone https://github.com/ravindrakumawat/e-app
cd e-app
docker build . -t eapp:1.0
docker run -itd -p 3000:3000 -e CLEAR_BIT_KEY=<YOUR_CLEAR_BIT_KEY> eapp:1.0
```
