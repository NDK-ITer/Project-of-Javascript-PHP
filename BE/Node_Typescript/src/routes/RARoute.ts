import RAController from "../controllers/RAController";
import AuthMiddleware from "../middlewares/AuthMiddleware";

const raRoute = require('express').Router();
/**
 * @swagger
 * /ra/public:
 *      get:
 *          summary: Send the text to the server
 *          tags:
 *              - raRoute
 *          description: Send a message to the server and get a response added to the original text.
 *          requestBody:
 *              required: true
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              responseText:
 *                                  type: string
 *                                  example: This is some example string! This is an endpoint
 *          responses:
 *              201:
 *                  description: Success
 *                  content:
 *                      application/json:
 *                          schema:
 *                              type: object
 *                              properties:
 *                                  text:
 *                                      type: string
 *                                      example: This is some example string!
 *              404:
 *                  description: Not found
 *              500:
 *                  description: Internal server error
 */
raRoute.get('/public', RAController.GetById)
/**
 * @swagger
 * /ra/public/all:
 *      get:
 *          summary: Send the text to the server
 *          tags:
 *              - raRoute
 *          description: Send a message to the server and get a response added to the original text.
 *          requestBody:
 *              required: true
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              responseText:
 *                                  type: string
 *                                  example: This is some example string! This is an endpoint
 *          responses:
 *              201:
 *                  description: Success
 *                  content:
 *                      application/json:
 *                          schema:
 *                              type: object
 *                              properties:
 *                                  text:
 *                                      type: string
 *                                      example: This is some example string!
 *              404:
 *                  description: Not found
 *              500:
 *                  description: Internal server error
 */
raRoute.get('/public/all', RAController.GetPublic)
raRoute.get('/public/:employerId', RAController.GetByEmployer)
/**
 * @swagger
 * /ra/upload:
 *      post:
 *          summary: Send the text to the server
 *          tags:
 *              - raRoute
 *          description: Send a message to the server and get a response added to the original text.
 *          requestBody:
 *              required: true
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              responseText:
 *                                  type: string
 *                                  example: This is some example string! This is an endpoint
 *          responses:
 *              201:
 *                  description: Success
 *                  content:
 *                      application/json:
 *                          schema:
 *                              type: object
 *                              properties:
 *                                  text:
 *                                      type: string
 *                                      example: This is some example string!
 *              404:
 *                  description: Not found
 *              500:
 *                  description: Internal server error
 */
raRoute.post('/upload', AuthMiddleware.AuthenticateJWT ,RAController.Upload)
/**
 * @swagger
 * /ra/update:
 *      put:
 *          summary: Send the text to the server
 *          tags:
 *              - raRoute
 *          description: Send a message to the server and get a response added to the original text.
 *          requestBody:
 *              required: true
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              responseText:
 *                                  type: string
 *                                  example: This is some example string! This is an endpoint
 *          responses:
 *              201:
 *                  description: Success
 *                  content:
 *                      application/json:
 *                          schema:
 *                              type: object
 *                              properties:
 *                                  text:
 *                                      type: string
 *                                      example: This is some example string!
 *              404:
 *                  description: Not found
 *              500:
 *                  description: Internal server error
 */
raRoute.put('/update', AuthMiddleware.AuthenticateJWT ,RAController.Edit)
/**
 * @swagger
 * /ra/apply:
 *      post:
 *          summary: Send the text to the server
 *          tags:
 *              - raRoute
 *          description: Send a message to the server and get a response added to the original text.
 *          requestBody:
 *              required: true
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              responseText:
 *                                  type: string
 *                                  example: This is some example string! This is an endpoint
 *          responses:
 *              201:
 *                  description: Success
 *                  content:
 *                      application/json:
 *                          schema:
 *                              type: object
 *                              properties:
 *                                  text:
 *                                      type: string
 *                                      example: This is some example string!
 *              404:
 *                  description: Not found
 *              500:
 *                  description: Internal server error
 */
raRoute.post('/apply', AuthMiddleware.AuthenticateJWT, RAController.Apply)
/**
 * @swagger
 * /ra/set-approved:
 *      put:
 *          summary: Send the text to the server
 *          tags:
 *              - raRoute
 *          description: Send a message to the server and get a response added to the original text.
 *          requestBody:
 *              required: true
 *              content:
 *                  application/json:
 *                      schema:
 *                          type: object
 *                          properties:
 *                              responseText:
 *                                  type: string
 *                                  example: This is some example string! This is an endpoint
 *          responses:
 *              201:
 *                  description: Success
 *                  content:
 *                      application/json:
 *                          schema:
 *                              type: object
 *                              properties:
 *                                  text:
 *                                      type: string
 *                                      example: This is some example string!
 *              404:
 *                  description: Not found
 *              500:
 *                  description: Internal server error
 */
raRoute.put('/set-approved', AuthMiddleware.AuthenticateJWT, RAController.SetApproved)
// raRoute.put('/')

export default raRoute;