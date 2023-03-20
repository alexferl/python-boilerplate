from app import configure, create_app


if __name__ == "__main__":
    configure()
    app = create_app()
    app.run()
