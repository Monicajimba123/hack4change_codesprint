from app import db, User, app

with app.app_context():
    farmer = User(name='Sita Farmer', email='sita@example.com', role='Supplier')
    db.session.add(farmer)
    db.session.commit()
    print(f"Farmer added with ID: {farmer.id}")
