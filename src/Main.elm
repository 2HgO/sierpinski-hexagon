module Main exposing (..)

import Array exposing (..)
import Browser
import Html exposing (Html)
import Html.Attributes
import Random exposing (int, initialSeed, generate)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Point =
  { x : Float
  , y : Float
  }

type alias Model =
  { seed : Random.Seed
  , pts : List Point
  , lastPnt : Point
  , count : Int
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model (initialSeed 0) [Point 80 200] (Point 80 200) 1
  , Cmd.none
  )

toSVG : Point -> Svg msg
toSVG point =
  circle [ fill "#FFFFFF", cx (String.fromFloat point.x), cy (String.fromFloat point.y), r "1" ] []

type Msg =
  Tick Time.Posix
  | Draw Int

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick _ ->
      (model
      , generate Draw randIdx
      )
    Draw idx ->
      let
        maybePnt = Array.get idx edges
        _ = Debug.log "count" model.count
      in
      case maybePnt of
        Nothing ->
          ( model, Cmd.none )
        Just pnt ->
          let
            mid = midpoint (Tuple.first pnt) (Tuple.second pnt) model.lastPnt
          in
          ( { model | pts = mid :: model.pts, lastPnt = mid, count = model.count+1}
          , Cmd.none
          )

midpoint : Point -> Point -> Point -> Point
midpoint p1 p2 p3 =
  Point ((p1.x + p2.x + p3.x) / 3) ((p1.y + p2.y + p3.y) / 3)

edges : Array (Point, Point)
edges =
  Array.fromList [ (Point 150 280, Point 236.603 230)
  , ( Point 236.603 230, Point 236.603 130 )
  , ( Point 236.603 130, Point 150 80 )
  , ( Point 150 80, Point 63.397 130 )
  , ( Point 63.397 130, Point 63.397 230 )
  , ( Point 63.397 230, Point 150 280 )
  ]

randIdx = int 0 5

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every 1 Tick

drawing: List Point -> Html msg
drawing pts =
  svg [ version "1.1", x "0", y "0", viewBox "0 0 323.141 322.95" ]
    ([ polygon [ stroke "#FFFFFF", points "150,280 236.603,230 236.603,130 150,80 63.397,130 63.397,230" ] [] ] ++ (List.map toSVG pts))

view : Model -> Html Msg
view model =
  Html.div [ Html.Attributes.style "background-color" "black", Html.Attributes.style "height" "100%", Html.Attributes.style "position" "absolute", Html.Attributes.style "width" "100%" ] [
    Html.div [ Html.Attributes.style "width" "50%", Html.Attributes.style "top" "20%", Html.Attributes.style "margin" "0 auto"]
    [ drawing model.pts ]
  ]
