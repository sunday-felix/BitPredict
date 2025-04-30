;; Title: BitPredict - Decentralized Bitcoin Price Prediction Markets

;; Summary: 
;; A decentralized prediction market platform built on Stacks for Bitcoin price movement forecasting.
;; Users can stake STX tokens on whether BTC price will go up or down within a specified timeframe.

;; Description:
;; BitPredict enables trustless price prediction markets using Stacks' Bitcoin-anchored security.
;; The contract supports market creation, user predictions, outcome resolution via oracle, and
;; automatic distribution of winnings. A small platform fee is collected for sustainability.
;; This implementation is fully compliant with Stacks layer 2 and Bitcoin settlement requirements.

;; Constants

;; Administrative Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))

;; Error Code Constants
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; State Variables

;; Platform Configuration
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(define-data-var minimum-stake uint u1000000) ;; 1 STX minimum stake
(define-data-var fee-percentage uint u2) ;; 2% platform fee
(define-data-var market-counter uint u0)

;; Data Maps

;; Market Data Structure
(define-map markets
    uint
    {
        start-price: uint,
        end-price: uint,
        total-up-stake: uint,
        total-down-stake: uint,
        start-block: uint,
        end-block: uint,
        resolved: bool
    }
)

