defmodule AccountManagerWeb.UsersControllerTest do
  @moduledoc false

  use AccountManagerWeb.ConnCase

  alias AccountManager.Users

  describe "create/2" do
    test "creates a user and returns a token", %{conn: conn} do
      params = %{
        username: "oteixeiras",
        document: "17599376522",
        phone: "2222222222",
        age: 24,
        password: "123456",
        email: "oteixeiras@gmail.com",
        zip_code: "11111111",
        state_acronym: "ES"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "email" => "oteixeiras@gmail.com",
                 "access_token" => _token,
                 "id" => _id,
                 "username" => "oteixeiras"
               },
               "message" => "User created"
             } = response
    end

    test "when there are invalid params return an error", %{conn: conn} do
      invalid_params = %{
        username: "oteixeiras",
        document: "12",
        phone: "11997038222",
        age: 29,
        password: "12345",
        email: "oteixeiras@gmail.com",
        zip_code: "11111111",
        state_acronym: "TT"
      }

      response =
        conn
        |> post(~p"/api/users", invalid_params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "document" => ["should be at least 11 character(s)"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn} do
      params = %{
        "username" => "oteixeiras",
        "document" => "17599376522",
        "phone" => "2222222222",
        "age" => 24,
        "password" => "123456",
        "email" => "teste@gmail.com",
        "zip_code" => "11111111",
        "state_acronym" => "ES"
      }

      {:ok, user} =
        Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{user.email}")
        |> json_response(:ok)

      assert %{
               "data" => %{"email" => "teste@gmail.com", "id" => _id, "username" => "oteixeiras"},
               "message" => "User deleted"
             } = response
    end

    test "not found user for delete", %{conn: conn} do
      response =
        conn
        |> delete(~p"/api/users/99999999999")
        |> json_response(:not_found)

      assert response == %{"message" => "Resource not found"}
    end
  end

  describe "login/2" do
    test "successfully login when user exist with valid credentials", %{conn: conn} do
      params = %{
        "username" => "oteixeiras",
        "document" => "17599376522",
        "phone" => "2222222222",
        "age" => 24,
        "password" => "123456",
        "email" => "teste@gmail.com",
        "zip_code" => "11111111",
        "state_acronym" => "ES"
      }

      {:ok, _user} =
        Users.create(params)

      body = %{password: Map.get(params, "password"), email: Map.get(params, "email")}

      response =
        conn
        |> post(~p"/api/users/login", body)
        |> json_response(:ok)

      assert %{
               "message" => "User authenticated successfully!",
               "access_token" => _token
             } = response
    end

    # test "When user exist with invalid credentials", %{conn: conn} do
  end

  # describe "show/2" do
end
