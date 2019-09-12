var express = require('express');

var router = express.Router();

router.get('/', async (req, res) => {
    await req.context.db.users.findAll()
        .then(users => {
            return res.send(users)
        })
        .catch(err => {
            return res.status(400).send(req.context.handleError(err))
        }
        );
});
router.get('/:userId', async (req, res) => {
    await req.context.db.users.findByPk(
        req.params.userId
    )
        .then(user => {
            if (!user) {
                return res.status(404).send()
            }
            return res.send(user)
        })
        .catch(err => {
            return res.status(400).send(req.context.handleError(err))
        }
        );
});
router.post('/', async (req, res) => {
    if (req.body.user) {
        req.body.user.id = null
    }
    await req.context.db.users.create(
        req.body.user
    )
        .then(user => {
            return res.send(user)
        })
        .catch(err => {
            return res.status(400).send(req.context.handleError(err))
        }
        );
});
router.post('/:userId', async (req, res) => {
    if (req.body.user) {
        req.body.user.id = undefined
    }
    await req.context.db.users.update(
        req.body.user,
        {
            where: { id: req.params.userId }
        })
        .then(count => {
            if (count == 0) {
                return res.status(404).send()
            }
            return res.send(true)
        })
        .catch(err => {
            return res.status(400).send(req.context.handleError(err))
        }
        );
});
router.delete('/:userId', async (req, res) => {
    await req.context.db.users.destroy({
        where: { id: req.params.userId }
    })
        .then(count => {
            if (count == 0) {
                return res.status(404).send()
            }
            return res.send(true)
        })
        .catch(err => {
            return res.status(400).send(req.context.handleError(err))
        }
        );
});

module.exports = router;