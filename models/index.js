const Sequelize = require('sequelize');

const sequelize = new Sequelize({
    dialect: 'sqlite',
    storage: './db/shine_way.db'
});

module.exports = {
    sequelize,
    db: {
        advertisements: sequelize.import('./advertisements'),
        attachments: sequelize.import('./attachments'),
        comments: sequelize.import('./comments'),
        details: sequelize.import('./details'),
        emails: sequelize.import('./emails'),
        locations: sequelize.import('./locations'),
        phones: sequelize.import('./phones'),
        places: sequelize.import('./places'),
        subscriptions: sequelize.import('./subscriptions'),
        user_place_junctions: sequelize.import('./user_place_junctions'),
        users: sequelize.import('./users'),
        user_subscription_junctions: sequelize.import('./user_subscription_junctions'),
        user_user_junctions: sequelize.import('./user_user_junctions'),
        user_visit_junctions: sequelize.import('./user_visit_junctions'),
        user_voucher_junctions: sequelize.import('./user_voucher_junctions'),
        visits: sequelize.import('./visits'),
        votes: sequelize.import('./votes'),
        vouchers: sequelize.import('./vouchers')
    }
}