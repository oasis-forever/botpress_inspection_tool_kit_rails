## 4. Deploy Botpress Server to Heroku

1. Create `Dockerfile` and fill it in with the following values.
```
FROM botpress/server:v12_15_1
WORKDIR /botpress
CMD ["./bp"]
```

---

2. Create Botpress Server application
```bash
$ heroku create oasist-botpress-server
```

---

3. Login to the container registry
```bash
$ heroku container:login
```

---

4. Build the image
```bash
$ heroku container:push web --app oasist-botpress-server
```

---

5. Release the application
```bash
$ heroku container:release web --app oasist-botpress-server
```

Now, you can use the application at `https://oasist-botpress-server.herokuapp.com/`
