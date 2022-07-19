require "application_system_test_case"

class CollabsTest < ApplicationSystemTestCase
  setup do
    @collab = collabs(:one)
  end

  test "visiting the index" do
    visit collabs_url
    assert_selector "h1", text: "Collabs"
  end

  test "should create collab" do
    visit collabs_url
    click_on "New collab"

    fill_in "Body", with: @collab.body
    fill_in "Integer", with: @collab.integer
    fill_in "Participants", with: @collab.participants
    fill_in "Title", with: @collab.title
    click_on "Create Collab"

    assert_text "Collab was successfully created"
    click_on "Back"
  end

  test "should update Collab" do
    visit collab_url(@collab)
    click_on "Edit this collab", match: :first

    fill_in "Body", with: @collab.body
    fill_in "Integer", with: @collab.integer
    fill_in "Participants", with: @collab.participants
    fill_in "Title", with: @collab.title
    click_on "Update Collab"

    assert_text "Collab was successfully updated"
    click_on "Back"
  end

  test "should destroy Collab" do
    visit collab_url(@collab)
    click_on "Destroy this collab", match: :first

    assert_text "Collab was successfully destroyed"
  end
end
