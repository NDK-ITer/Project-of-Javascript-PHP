import path from 'path';
import swaggerJsdoc from 'swagger-jsdoc';

const options = {
    definition: {
        openapi: '3.0.0',
        info: {
            title: 'API Documentation',
            version: '1.0.0',
            description: 'Documentation for API'
        },
        schemes: ["http", "https"],
        servers: [
            {
                url: 'http://localhost:7000/api',
                description: 'Development server'
            }
        ]
    },
    apis: [
        `${__dirname}/routes/*.ts`,
        `./routes/*.ts`
    ]
};

const specs = swaggerJsdoc(options);
export default specs;
