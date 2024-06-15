#
# app.py
#


from datetime import datetime
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///expenses.db"
db = SQLAlchemy(app)


class Expenses(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    amount = db.Column(db.Float, nullable=False)
    date = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=False)


with app.app_context():
    db.create_all()


@app.get("/api/expenses")
def get_expenses():
    expenses = Expenses.query.all()

    return jsonify(
        [
            {
                "id": e.id,
                "amount": e.amount,
                "date": e.date,
                "description": e.description,
            }
            for e in expenses
        ]
    )


@app.post("/api/expenses")
def add_expenses():
    data = request.json

    if data:
        for expense in data:
            new_expense = Expenses(
                amount=expense["amount"],
                date=expense["date"],
                description=expense["description"],
            )

            db.session.add(new_expense)

        db.session.commit()

        return "", 201

    return "", 200
