const express = require("express");

const routes = require('./routes');
const models = require('./models');

const db = models.db

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(async (req, res, next) => {
    req.context = {
        handleError: err => {
            if (err.errors) {
                err = err.errors.map(e => e.message).join()
            }
            else if (err.message) {
                err = err.message
            }
            console.error(err);
            return err;
        },
        db,
        // me: await db.users.findByPk(1)
    };
    next();
});

app.use('/advertisements', routes.advertisements);
app.use('/comments', routes.comments);
app.use('/places', routes.places);
app.use('/subscriptions', routes.subscriptions);
app.use('/users', routes.users);
app.use('/visits', routes.visits);
app.use('/votes', routes.votes);
app.use('/vouchers', routes.vouchers);

app.get('/', (req, res) => {
    return res.send("Running...");
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});